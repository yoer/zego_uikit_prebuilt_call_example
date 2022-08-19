package com.test.calldemo;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.zegocloud.uikit.components.audiovideo.ZegoViewProvider;
import com.zegocloud.uikit.prebuilts.call.ZegoUIKitPrebuiltCallConfig;
import com.zegocloud.uikit.prebuilts.call.ZegoUIKitPrebuiltCallFragment;
import com.zegocloud.uikit.prebuilts.call.internal.ZegoVideoForegroundView;
import com.zegocloud.uikit.service.ZegoScenario;
import com.zegocloud.uikit.service.ZegoUIKitUser;

public class CallActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_call);

        addCallFragment();
    }

    public void addCallFragment() {
        long appID = yourAppID;
        String appSign = yourAppSign;

        String roomID = "123456";
        String userID = Build.MANUFACTURER;
        String userName = userID;

        ZegoUIKitPrebuiltCallConfig config = new ZegoUIKitPrebuiltCallConfig();
        ZegoUIKitPrebuiltCallFragment fragment = ZegoUIKitPrebuiltCallFragment.newInstance(
            appID, appSign, roomID, userID, userName, ZegoScenario.GENERAL, config);
        fragment.setForegroundViewProvider(new ZegoViewProvider() {
            @Override
            public View getForegroundView(ZegoUIKitUser userInfo) {
                // AudioVideoForegroundView is your own widget that show user level label based on user.userID
                ZegoVideoForegroundView foregroundView = new ZegoVideoForegroundView(CallActivity.this, userInfo);
                return foregroundView;
            }
        });
        getSupportFragmentManager().beginTransaction()
            .replace(R.id.fragment_container, fragment)
            .commitNow();
    }
}