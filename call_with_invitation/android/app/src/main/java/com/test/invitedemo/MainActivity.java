package com.test.invitedemo;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.textfield.TextInputLayout;
import com.zegocloud.uikit.components.invite.ZegoInvitationType;
import com.zegocloud.uikit.prebuilts.call.ZegoMenuBarButtonName;
import com.zegocloud.uikit.prebuilts.call.ZegoUIKitPrebuiltCallConfig;
import com.zegocloud.uikit.prebuilts.callinvite.ZegoCallInvitationData;
import com.zegocloud.uikit.prebuilts.callinvite.ZegoStartCallInvitationButton;
import com.zegocloud.uikit.prebuilts.callinvite.ZegoUIKitPrebuiltCallConfigProvider;
import com.zegocloud.uikit.prebuilts.callinvite.ZegoUIKitPrebuiltCallInvitationService;
import com.zegocloud.uikit.service.ZegoUIKitUser;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView yourUserID = findViewById(R.id.your_user_id);
        String generateUserID = generateUserID();
        yourUserID.setText("Your User ID :" + generateUserID);

        initCallInviteService(generateUserID);

        initVoiceButton();

        initVideoButton();
    }

    private void initVideoButton() {
        ZegoStartCallInvitationButton newVideoCall = findViewById(R.id.new_video_call);
        newVideoCall.setIsVideoCall(true);
        newVideoCall.setOnClickListener(v -> {
            TextInputLayout inputLayout = findViewById(R.id.target_user_id);
            String targetUserID = inputLayout.getEditText().getText().toString();
            newVideoCall.setInvitees(Collections.singletonList(new ZegoUIKitUser(targetUserID)));
        });
    }

    private void initVoiceButton() {
        ZegoStartCallInvitationButton newVoiceCall = findViewById(R.id.new_voice_call);
        newVoiceCall.setIsVideoCall(false);
        newVoiceCall.setOnClickListener(v -> {
            TextInputLayout inputLayout = findViewById(R.id.target_user_id);
            String targetUserID = inputLayout.getEditText().getText().toString();
            newVoiceCall.setInvitees(Collections.singletonList(new ZegoUIKitUser(targetUserID)));
        });
    }

    public void initCallInviteService(String generateUserID) {
        long appID = yourAppID;
        String appSign = yourAppSign;

        String userID = generateUserID;
        String userName = userID;

        ZegoUIKitPrebuiltCallInvitationService.init(getApplication(), appID, appSign, userID, userName);
        ZegoUIKitPrebuiltCallInvitationService.setPrebuiltCallConfigProvider(new ZegoUIKitPrebuiltCallConfigProvider() {
            @Override
            public ZegoUIKitPrebuiltCallConfig getConfig(ZegoCallInvitationData invitationData) {
                ZegoUIKitPrebuiltCallConfig callConfig = new ZegoUIKitPrebuiltCallConfig();
                boolean isVideoCall = invitationData.type == ZegoInvitationType.VIDEO_CALL.getValue();
                callConfig.turnOnCameraWhenJoining = isVideoCall;
                if (!isVideoCall) {
                    callConfig.menuBarButtons = Arrays.asList(
                        ZegoMenuBarButtonName.TOGGLE_MICROPHONE_BUTTON,
                        ZegoMenuBarButtonName.SWITCH_AUDIO_OUTPUT_BUTTON,
                        ZegoMenuBarButtonName.HANG_UP_BUTTON);
                }
                return callConfig;
            }
        });
    }

    private String generateUserID() {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        while (builder.length() < 5) {
            int nextInt = random.nextInt(10);
            if (builder.length() == 0 && nextInt == 0) {
                continue;
            }
            builder.append(nextInt);
        }
        return builder.toString();
    }

     @Override
    protected void onDestroy() {
        super.onDestroy();
        ZegoUIKitPrebuiltCallInvitationService.logout();
    }

}