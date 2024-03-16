package com.nimeshmlakshan.onlinemusicappclient;

import static android.Manifest.permission.RECORD_AUDIO;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.view.MotionEvent;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.nimeshmlakshan.onlinemusicappclient.databinding.ActivityMainScreenBinding;

import java.util.ArrayList;

public class MainScreen extends AppCompatActivity {

    // view binding
    private ActivityMainScreenBinding binding;

    // Voice Command
    private SpeechRecognizer speechRecognizer;
    private Intent intentRecognizer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        binding = ActivityMainScreenBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // handle loginBtn click , start login screen
        binding.loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(MainScreen.this,LoginActivity.class));
            }
        });

        // Voice Command
        ActivityCompat.requestPermissions(this, new String[]{RECORD_AUDIO}, PackageManager.PERMISSION_GRANTED);

        intentRecognizer = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intentRecognizer.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);

        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(this);
        speechRecognizer.setRecognitionListener(new RecognitionListener() {
            @Override
            public void onReadyForSpeech(Bundle bundle) {}

            @Override
            public void onBeginningOfSpeech() {}

            @Override
            public void onRmsChanged(float v) {}

            @Override
            public void onBufferReceived(byte[] bytes) {}

            @Override
            public void onEndOfSpeech() {}

            @Override
            public void onError(int i) {
                // Handle any errors that may occur while using the SpeechRecognizer object
                //Toast.makeText(MainScreen.this, "Tell me", Toast.LENGTH_SHORT).show();
                speechRecognizer.startListening(intentRecognizer);
            }

            @Override
            public void onResults(Bundle bundle) {
                ArrayList<String> matches = bundle.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);
                String string = "";
                if (matches != null) {
                    string = matches.get(0);

                    if (string.toLowerCase().equals("login")) {
                        Intent intent = new Intent(MainScreen.this, LoginActivity.class);
                        startActivity(intent);
                    }
                }

                // Start listening for voice commands again
                speechRecognizer.startListening(intentRecognizer);

                // Enable continuous listening by adding a delay before starting to listen again
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        speechRecognizer.startListening(intentRecognizer);
                    }
                }, 200); // Delay for 1 second before starting to listen again
            }


            @Override
            public void onPartialResults(Bundle bundle) {}

            @Override
            public void onEvent(int i, Bundle bundle) {}
        });

        // Start listening for voice commands
        speechRecognizer.startListening(intentRecognizer);

        // handle loginBtn click , start login screen
        binding.loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(MainScreen.this,LoginActivity.class));
            }
        });

        // handle skipBtn click , start continue without login screen
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Stop listening for voice commands when the activity is destroyed
        speechRecognizer.stopListening();
        speechRecognizer.destroy();
    }

    @Override
    protected void onResume() {
        super.onResume();
        speechRecognizer.startListening(intentRecognizer);
    }



}
