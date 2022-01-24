
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
// import io.card91.android.sdk.*;
// import io.card91.android.sdk.ui.verification.C91VerifyMobileScreen;
// import io.card91.android.sdk.ui.new_flow_v1.V1MPinActivity;
import com.card91.sdk.kissht.C91MainActivity
// import io.card91.android.sdk.utils.C91Constant;
// import io.card91.android.sdk.utils.SdkEnv;
import com.card91.sdk.kissht.utils.C91Constant
import com.card91.sdk.kissht.utils.SdkEnv
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
    void navigateToCustomerSDK(String params) {
        try {
            ReactApplicationContext context = getReactApplicationContext();
            Intent intent = new Intent(context, C91MainActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra(C91Constant.SDK_PARAMS, params);
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}