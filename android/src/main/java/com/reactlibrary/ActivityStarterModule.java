
package com.reactlibrary;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

import androidx.annotation.NonNull;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.CatalystInstance;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
// import com.card91.samplecalculator.*;
//import io.card91.android.sdk.ui.new_flow_v1.*;
import io.card91.android.sdk.*;
// import io.card91.android.sdk.ui.verification.C91VerifyMobileScreen;
import io.card91.android.sdk.ui.new_flow_v1.V1MPinActivity;
import io.card91.android.sdk.utils.C91Constant;
import io.card91.android.sdk.utils.SdkEnv;

import com.facebook.react.bridge.WritableNativeArray;

class ActivityStarterModule extends ReactContextBaseJavaModule {

    ActivityStarterModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public void initialize() {
        super.initialize();
    }

    @Override
    public String getName() {
        return "ActivityStarter";
    }

    @ReactMethod
    void navigateToCustomerSDK(String mobileNumber, String deviceID, String env) {
        try {
            ReactApplicationContext context = getReactApplicationContext();
            Intent intent = new Intent(context, V1MPinActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            switch (env.toUpperCase()) {
                case "DEV":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEV);
                    break;
                case "DEV_LIVE":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEV_LIVE);
                    break;
                case "UAT":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.UAT);
                    break;
                case "UAT_LIVE,":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.UAT_LIVE);
                    break;
                case "DEMO_LIVE,":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEMO_LIVE);
                    break;
                case "DEMO_SANDBOX":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEMO_SANDBOX);
                    break;
                case "STAGE_SANDBOX":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.STAGE_SANDBOX);
                    break;
                case "STAGE_LIVE":
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.STAGE_LIVE);
                    break;
                default:
                    intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEV);
            }
            intent.putExtra(C91Constant.NUMBER, mobileNumber);
            intent.putExtra(C91Constant.DEVICE_ID, deviceID);
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}