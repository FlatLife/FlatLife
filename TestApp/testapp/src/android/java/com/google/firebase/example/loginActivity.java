package com.google.firebase.example;
//need to insert package for c++ files, e.g. com.mycompany.mypackage;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.google.firebase.cpp.database.testapp.R;

public class loginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        
        Button mLogInButton = (Button)findViewById(R.id.btn_login);
        mLogInButton.setOnClickListener(this);
        Button mSignUpButton = (Button)findViewById(R.id.btn_signup);
        mSignUpButton.setOnClickListener(this);
    }
    
    public static native void logInCall();
    
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btn_login: {
                //handler for login button
                logInCall();
                break;
            }
            case R.id.btn_signup: {
                //handler for signup button
                break;
            }
            break;
        }
    }
   
}
