/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.general.login;
import java.security.SecureRandom;
import java.util.Random;

/**
 *
 * @author jonathanseetoh
 */
public class PasswordGeneration {
    

  private static final Random RANDOM = new SecureRandom();
  /** Length of password. @see #generateRandomPassword() */
  public static final int PASSWORD_LENGTH = 8;
  /**
   * Generate a random String suitable for use as a temporary password.
   *
   * @return String suitable for use as a temporary password
   */
  public static String generateRandomPassword()
  {
      // Pick from some letters that won't be easily mistaken for each
      // other.omitted o O and 0, 1 l and L.
      String letters = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";

      String pw = "";
      for (int i=0; i<PASSWORD_LENGTH; i++)
      {
          int index = (int)(RANDOM.nextDouble()*letters.length());
          pw += letters.substring(index, index+1);
      }
      return pw;
  }
}