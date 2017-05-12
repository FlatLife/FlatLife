package com.google.firebase.example;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.google.firebase.cpp.database.testapp.R;

public class LoginActivity extends AppCompatActivity {

    public static native void logInCall();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        Button mLogInButton = (Button) findViewById(R.id.btn_login);
        if (mLogInButton != null) {
            mLogInButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    logInCall();
                }
            });
        }
        Button mSignUpButton = (Button) findViewById(R.id.btn_signup);
        if (mSignUpButton != null) {
            mSignUpButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                }
            });
        }
    }
}
