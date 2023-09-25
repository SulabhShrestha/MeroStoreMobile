# Merostore - Manage your all stores using single app

* This is my 6th sem project.

___

## Errors with solution

### PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)

* First make sure that you have java installed
* Move to the android folder and type `./gradlew signingReport` to generate sha keys.
* Copy the sha1 value of report having `varient` and `config` being debug and paste it in here: [Google Cloud](https://console.cloud.google.com/apis/credentials). Make sure that you have created project in google cloud.
* There you go.
