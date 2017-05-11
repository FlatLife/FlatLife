package com.google.firebase.example;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.google.firebase.cpp.database.testapp.R;

public class loginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
    }
}
