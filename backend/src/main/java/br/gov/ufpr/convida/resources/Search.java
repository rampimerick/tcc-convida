package br.gov.ufpr.convida.resources;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class Search {

    public static String decode(String text) {
        try {
            return URLDecoder.decode(text, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "";
        }
    }
}