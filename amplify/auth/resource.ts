import { defineAuth, secret } from '@aws-amplify/backend';
import { preSignUp } from './pre-sign-up/resource';
/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */
export const auth = defineAuth({
  // email verified for other providers: https://stackoverflow.com/questions/68859052/aws-cognito-email-unverified-on-main-account-after-adminlinkproviderforuser
  triggers: {
    preSignUp,
  },
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: secret('GOOGLE_CLIENT_ID'),
        clientSecret: secret('GOOGLE_CLIENT_SECRET'),
        scopes: ['email'],
        attributeMapping: {
          email: 'email',
          emailVerified: 'email_verified'
        }
      },
      // signInWithApple: {
      //   clientId: secret('SIWA_CLIENT_ID'),
      //   keyId: secret('SIWA_KEY_ID'),
      //   privateKey: secret('SIWA_PRIVATE_KEY'),
      //   teamId: secret('SIWA_TEAM_ID'),
      //   scopes: ['email'],
      //   attributeMapping: {
      //     email: 'email',
      //   }
      // },
      callbackUrls: [
        'http://localhost:8080/', 'jobturbo://'
      ],
      logoutUrls: ['http://localhost:8080/', 'jobturbo://'],
    }
  },
});
