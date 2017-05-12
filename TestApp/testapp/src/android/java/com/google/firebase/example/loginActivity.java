package com.google.firebase.example;

//need to insert package for c++ files, e.g. com.mycompany.mypackage;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.google.firebase.cpp.database.testapp.R;


public class loginActivity extends AppCompatActivity {

    public static native void logInCall();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        Button mLogInButton = (Button) findViewById(R.id.btn_login);
        mLogInButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                logInCall();
            }
        });
        Button mSignUpButton = (Button) findViewById(R.id.btn_signup);
        mSignUpButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }
}
