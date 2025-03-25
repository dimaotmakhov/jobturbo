# run app

flutter pub get && flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

# first time configure AWS cli

(curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && rm awscliv2.zip)
./aws/dist/aws configure sso
amplify-admin
https://d-9067ff5a9c.awsapps.com/start
us-east-1
default
./aws/dist/aws configure export-credentials --format env-no-export > .env.aws
echo $'\nAWS_REGION=us-east-1' >> .env.aws

# amplify sandbox

npx dotenvx run -f .env.aws .env.development -- npx ampx sandbox --stream-function-logs --outputs-format dart --outputs-out-dir lib

# generate dart graphql client code and backend lambdas

npx dotenvx run -f .env.aws -- npx ampx generate graphql-client-code --format modelgen --model-target dart --out lib/models
npx dotenvx run -f .env.aws -- npx ampx generate graphql-client-code --out amplify/functions/graphql

# generate .dart translation files localization

flutter gen-l10n

# Generate app store screenshots

flutter test --update-goldens test/golden_test.dart

# Upload screenshots

sudo apt update
sudo apt-get install ruby ruby-dev build-essential
sudo gem install fastlane
cd ios/
sudo fastlane deliver init --use_live_version true # download current app data
fastlane deployapp versionName:"1.0.9" # upload

# change build number ios replace in ios/Runner.xcodeproj/project.pbxproj

CURRENT_PROJECT_VERSION =

# download dependencies

flutter pub get

# set local secret

npx ampx sandbox secret set GOOGLE_CLIENT_ID

# Run IOS simulator

flutter pub get
cd ios
pod install

# Generate production amplify outputs

npx ampx generate outputs --app-id d2kifahm4pmdj8 --branch main --format dart && mv amplify_outputs.dart lib/amplify_outputs_production.dart

# Run website

(cd jobturboappwebsite && npm i && ./node_modules/.bin/astro dev --host=0.0.0.0)

# Deploy website

(cd jobturboappwebsite && npm run deploy)
