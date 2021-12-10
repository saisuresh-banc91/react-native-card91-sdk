// Card91SdkManager.java

package com.reactlibrary;

import android.view.View;

import androidx.appcompat.widget.AppCompatCheckBox;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import android.content.Intent;
import com.card91.samplecalculator.*;
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
            Intent intent = new Intent(c, CalculatorActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
             c.startActivity(intent);
        cb.setChecked(true);
        return cb;
    }
}
