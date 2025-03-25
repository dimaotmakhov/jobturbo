import {
    Context,
    PreSignUpTriggerEvent,
    PreSignUpTriggerHandler,
  } from "aws-lambda";
  import { CognitoIdentityServiceProvider } from "aws-sdk";
  import {
    AdminLinkProviderForUserResponse,
    AdminSetUserPasswordResponse,
  } from "@aws-sdk/client-cognito-identity-provider";

  export const handler: PreSignUpTriggerHandler = async (
    event: PreSignUpTriggerEvent,
    _context: Context
  ) => {

    console.log(`Presignup triggered: ${JSON.stringify(event)}`);

    const {
      triggerSource,
      userPoolId,
      userName,
      request: {
        // only properties specified as required are available here
        userAttributes: { email },
      },
    } = event;

    if (triggerSource === "PreSignUp_ExternalProvider") {
      // --> User has registered with Google/Facebook external providers
      const usersFilteredByEmail = await listUsersByEmail({
        userPoolId,
        email,
      });
  
      // userName example: "Facebook_12324325436" or "Google_1237823478"
      const [providerNameValue, providerUserId] = userName.split("_");
      // Uppercase the first letter because the event sometimes
      // has it as google_1234 or facebook_1234. In the call to `adminLinkProviderForUser`
      // the provider name has to be Google or Facebook (first letter capitalized)
      const providerName =
        providerNameValue.charAt(0).toUpperCase() + providerNameValue.slice(1);
  
      if (usersFilteredByEmail.Users && usersFilteredByEmail.Users.length > 0) {
        console.log(`user has a cognito native account`)

        // user already has cognito account
        const cognitoUsername =
          usersFilteredByEmail.Users[0].Username || "username-not-found";
  
        // if they have access to the Google / Facebook account of email X, verify their email.
        // even if their cognito native account is not verified
        await adminLinkUserAccounts({
          username: cognitoUsername,
          userPoolId,
          providerName,
          providerUserId,
        });
      } else {
        console.log(`user does not have a cognito native account`)

        /* --> user does not have a cognito native account ->
              1. create a native cognito account
              2. change the password, to change status from FORCE_CHANGE_PASSWORD to CONFIRMED
              3. merge the social and the native accounts
              4. add the user to a group - OPTIONAL
          */
  
        const createdCognitoUser = await adminCreateUser({
          userPoolId,
          email,
        });

        await adminSetUserPassword({ userPoolId, email });

        const cognitoNativeUsername =
          createdCognitoUser.User?.Username || "username-not-found";
  
        await adminLinkUserAccounts({
          username: cognitoNativeUsername,
          userPoolId,
          providerName,
          providerUserId,
        });

        event.response.autoVerifyEmail = true;
      }
    }
  
    // event.response.autoConfirmUser = true;
  
    return event;
  };
  
  /**
   * Gets a list of users based on an email within a pool
   * @param param0
   * @returns
   */
  export const listUsersByEmail = async ({
    userPoolId,
    email,
  }: {
    userPoolId: string;
    email: string;
  }): Promise<any> => {
    const params = {
      UserPoolId: userPoolId,
      Filter: `email = "${email}"`,
    };
  
    const cognitoIdp = new CognitoIdentityServiceProvider();
    return cognitoIdp.listUsers(params).promise();
  };
  
  export const adminLinkUserAccounts = async ({
    username,
    userPoolId,
    providerName,
    providerUserId,
  }: {
    username: string;
    userPoolId: string;
    providerName: string;
    providerUserId: string;
  }): Promise<AdminLinkProviderForUserResponse> => {
    const params = {
      DestinationUser: {
        ProviderAttributeValue: username,
        ProviderName: "Cognito",
      },
      SourceUser: {
        ProviderAttributeName: "Cognito_Subject",
        ProviderAttributeValue: providerUserId,
        ProviderName: providerName,
      },
      UserPoolId: userPoolId,
    };
  
    const cognitoIdp = new CognitoIdentityServiceProvider();
    return new Promise((resolve, reject) => {
      cognitoIdp.adminLinkProviderForUser(params, (err, data) => {
        if (err) {
          reject(err);
          return;
        }
        resolve(data);
      });
    });
  };
  
  /**
   * Creates a cognito user
   * @param param0
   * @returns
   */
  export const adminCreateUser = async ({
    userPoolId,
    email,
  }: {
    userPoolId: string;
    email: string;
  }): Promise<AWS.CognitoIdentityServiceProvider.AdminCreateUserResponse> => {
    const createUserParams = {
      UserPoolId: userPoolId,
      // SUPPRESS prevents sending an email with the temporary password
      // to the user on account creation
      MessageAction: "SUPPRESS",
      Username: email,
      UserAttributes: [
        {
          Name: "email",
          Value: email,
        },
        {
          Name: "email_verified",
          Value: "true",
        },
      ],
    };
  
    const cognitoIdp = new CognitoIdentityServiceProvider();
    return cognitoIdp.adminCreateUser(createUserParams).promise();
  };
  
  /**
   * Sets a random password for an account
   * @param param0
   * @returns
   */
  export const adminSetUserPassword = async ({
    userPoolId,
    email,
  }: {
    userPoolId: string;
    email: string;
  }): Promise<AdminSetUserPasswordResponse> => {
    const params = {
      Password: generatePassword(),
      UserPoolId: userPoolId,
      Username: email,
      Permanent: true,
    };
  
    const cognitoIdp = new CognitoIdentityServiceProvider();
    return cognitoIdp.adminSetUserPassword(params).promise();
  };
  
  /**
   * Generates a random password
   * @returns
   */
  function generatePassword() {
    return `${Math.random() // Generate random number, eg: 0.123456
      .toString(36) // Convert  to base-36 : "0.4fzyo82mvyr"
      .slice(-16)}42T`; // Cut off last 16 characters; and add a number and uppercase character to match cognito password policy
  }
  