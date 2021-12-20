// Card91SdkManager.java

package com.reactlibrary;

import android.view.View;

import androidx.appcompat.widget.AppCompatCheckBox;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import android.content.Intent;
// import com.card91.samplecalculator.*;
import io.card91.android.sdk.ui.verification.C91VerifyMobileScreen;
import io.card91.android.sdk.utils.C91Constant;
import io.card91.android.sdk.utils.SdkEnv;


public class Card91SdkManager extends SimpleViewManager<View> {

    public static final String REACT_CLASS = "Card91Sdk";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public View createViewInstance(ThemedReactContext c) {
        // TODO: Implement some actually useful functionality
        AppCompatCheckBox cb = new AppCompatCheckBox(c);
            // Intent intent = new Intent(c, CalculatorActivity.class);
            // intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            Intent intent = new Intent(c, C91VerifyMobileScreen.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra(C91Constant.ENVIRONMENT, SdkEnv.DEV);
            intent.putExtra(C91Constant.NUMBER, "919876543213");
            intent.putExtra(C91Constant.DEVICE_ID, "uiyrdswe218973");
             c.startActivity(intent);
        cb.setChecked(true);
        return cb;
    }
}
