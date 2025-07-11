package kr.swj.baseball.common;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Encryptor {

    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public static String encode(String plainText) {
        return encoder.encode(plainText);
    }

    public static boolean matches(String plainText, String encodedText) {
        return encoder.matches(plainText, encodedText);
    }
}