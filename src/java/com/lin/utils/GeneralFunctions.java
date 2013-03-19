/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Yangsta
 */
public class GeneralFunctions {

    public static String getTimeSinceString(Date date) throws ParseException {
        String timeSince = "";
        Date now = new Date();
        // Convert to GMT time
        DateFormat dateTimeFormat =
                new SimpleDateFormat("dd MMM yyyy HH:mm:ss zzz");

        Date nowTimestamp = dateTimeFormat.parse(now.toGMTString());

        Long timeDiff =
                nowTimestamp.getTime() - date.getTime();

        int timeDiffMinutes = (int) ((timeDiff / 1000) / 60);
        if (timeDiffMinutes >= 43200) {
            // months scale
            int months = timeDiffMinutes / 43200;
            timeSince = "about " + Integer.toString(months);

            if (months > 1 || months == 0) {
                timeSince += " months ago";
            } else {
                timeSince += " month ago";
            }
        } else if (timeDiffMinutes >= 1440) {
            // days scale
            int days = timeDiffMinutes / 1440;
            timeSince = "about " + Integer.toString(days);

            if (days > 1 || days == 0) {
                timeSince += " days ago";
            } else {
                timeSince += " day ago";
            }
        } else if (timeDiffMinutes >= 60) {
            // hours scale
            int hours = timeDiffMinutes / 60;
            timeSince = "about " + Integer.toString(hours);

            if (hours > 1 || hours == 0) {
                timeSince += " hours ago";
            } else {
                timeSince += " hour ago";
            }
        } else if (timeDiffMinutes < 60) {
            // minutes scale
            timeSince = "about " + Integer.toString(timeDiffMinutes);

            if (timeDiffMinutes > 1) {
                timeSince += " minutes ago";
            } else {
                timeSince = "just a moment ago";
            }

        }

        return timeSince;
    }

    public static String getTimeLeftString(Date date) throws ParseException {
        String timeLeft = "";
        Date now = new Date();
        // Convert to GMT time
        SimpleDateFormat dateTimeFormat =
                new SimpleDateFormat("dd MMM yyyy HH:mm:ss zzz");

        Date nowTimestamp = dateTimeFormat.parse(now.toGMTString());

        Long timeDiff =
                date.getTime() - nowTimestamp.getTime();

        int timeDiffMinutes = (int) ((timeDiff / 1000) / 60);
        if (timeDiffMinutes >= 43200) {
            // months scale
            int months = timeDiffMinutes / 43200;
            timeLeft = "~" + Integer.toString(months) + " month(s)";
        } else if (timeDiffMinutes >= 1440) {
            // days scale
            int days = timeDiffMinutes / 1440;
            timeLeft = "~" + Integer.toString(days) + " day(s)";
        } else if (timeDiffMinutes >= 60) {
            // hours scale
            int hours = timeDiffMinutes / 60;
            timeLeft = "~" + Integer.toString(hours) + " hour(s)";
        } else if (timeDiffMinutes < 60) {
            // minutes scale
            timeLeft = "~" + Integer.toString(timeDiffMinutes)
                    + " minute(s)";
        }

        if (nowTimestamp.compareTo(date) > 0) {
            timeLeft = "expired";
        }

        return timeLeft;
    }

    /*
     * Returns formatted time since string as "2 days 10 mins"
     * Always returns two time outputs e.g. "1min 20 secs", "1 week 2 days", etc
     * Kinda ugly code, but it works ;P
     */
    public static String getTwoValueTimeLeftString(Date endingDateTime) throws ParseException {

        Date now = new Date();
        // Convert to GMT time
        SimpleDateFormat dateTimeFormat =
                new SimpleDateFormat("dd MMM yyyy HH:mm:ss zzz");

        Date nowTimestamp = dateTimeFormat.parse(now.toGMTString());

        if (nowTimestamp.compareTo(endingDateTime) > 0) {
            return null;
        }

        Long timeDiffConfirmedBy =
                endingDateTime.getTime() - nowTimestamp.getTime();

        int seconds = (int) (timeDiffConfirmedBy / 1000) % 60;
        int minutes = (int) ((timeDiffConfirmedBy / (1000 * 60)) % 60);
        int hours = (int) ((timeDiffConfirmedBy / (1000 * 60 * 60)) % 24);
        int days = (int) ((timeDiffConfirmedBy / (1000 * 60 * 60 * 24)) % 7);
        int weeks = (int) (timeDiffConfirmedBy / (1000 * 60 * 60 * 24 * 7));

        //number of output, eg "2 weeks 4 days" or "4hours 2 minutes" is 2 outputs
        int noOfOutput = 2;
        int outputCount = 0;
        String timeLeftConfirmedByString = "";

        if (weeks > 0) {
            timeLeftConfirmedByString += weeks + " week";
            if (weeks > 1) {
                timeLeftConfirmedByString += "s";
            }
            timeLeftConfirmedByString += " ";
            outputCount++;
        }
        if (days > 0) {
            timeLeftConfirmedByString += days + " day";
            if (days > 1) {
                timeLeftConfirmedByString += "s";
            }
            timeLeftConfirmedByString += " ";
            outputCount++;
        }
        if (hours > 0 && outputCount < noOfOutput) {
            timeLeftConfirmedByString += hours + " hour";
            if (hours > 1) {
                timeLeftConfirmedByString += "s";
            }
            timeLeftConfirmedByString += " ";
            outputCount++;
        }
        if (minutes > 0 && outputCount < noOfOutput) {
            timeLeftConfirmedByString += minutes + " minute";
            if (minutes > 1) {
                timeLeftConfirmedByString += "s";
            }
            timeLeftConfirmedByString += " ";
            outputCount++;
        }
        if (seconds > 0 && outputCount < noOfOutput) {
            timeLeftConfirmedByString += seconds + " sec";
            if (seconds > 1) {
                timeLeftConfirmedByString += "s";
            }
            timeLeftConfirmedByString += " ";
            outputCount++;
        }

        return timeLeftConfirmedByString;
    }
      
}
