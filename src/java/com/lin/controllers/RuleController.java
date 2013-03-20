/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.controllers;

import com.lin.dao.BookingDAO;
import com.lin.dao.FacilityDAO;
import com.lin.dao.FacilityTypeDAO;
import com.lin.dao.RuleDAO;
import com.lin.dao.UserDAO;
import com.lin.entities.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Set;

/**
 *
 * @author Keffeine
 */
public class RuleController {

    private ArrayList<String> errorMsg;
    private UserDAO uDAO;
    private BookingDAO bDAO;
    private RuleDAO rDAO;
    private FacilityTypeDAO tDAO;
    private FacilityDAO fDAO;

    public ArrayList<String> isFacilityAvailable(int userID, int facilityID, Date startBookingTime, Date endBookingTime) {
        errorMsg = new ArrayList<String>();


        bDAO = new BookingDAO();


        rDAO = new RuleDAO();
        tDAO = new FacilityTypeDAO();
        fDAO = new FacilityDAO();

        Facility facility = fDAO.getFacility(facilityID);
        FacilityType facilityType = facility.getFacilityType();
        int facilityTypeID = facilityType.getId();

        ArrayList<String> openRuleErrors = validateOpenRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> closeRuleErrors = validateCloseRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> limitRuleErrors = validateLimitRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> advanceRuleErrors = validateAdvanceRule(userID, facilityTypeID, startBookingTime, endBookingTime);
        ArrayList<String> clashErrors = validateClash(facility, startBookingTime, endBookingTime);


        if (!openRuleErrors.isEmpty()) {
            errorMsg.addAll(openRuleErrors);
        }
        if (!closeRuleErrors.isEmpty()) {
            errorMsg.addAll(closeRuleErrors);
        }
        if (!limitRuleErrors.isEmpty()) {
            errorMsg.addAll(limitRuleErrors);
        }
        if (!advanceRuleErrors.isEmpty()) {
            errorMsg.addAll(advanceRuleErrors);
        }
        if (!clashErrors.isEmpty()) {
            errorMsg.addAll(clashErrors);
        }



        return errorMsg;


    }

    private ArrayList<String> validateOpenRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> openRuleErrors = new ArrayList<String>();
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);

        boolean bookingValid = false;

        for (Object o : openRuleList) {
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek() == startBookingTime.getDay()) {
                Date openStart = openRule.getStartTime();
                Date openEnd = openRule.getEndTime();

                boolean startValid = false;
                boolean endValid = false;

                if (startBookingTime.getHours() == openStart.getHours() && startBookingTime.getMinutes() == openStart.getMinutes()) {
                    startValid = true;
                }

                if (openEnd.getHours() == endBookingTime.getHours() && endBookingTime.getMinutes() == openEnd.getMinutes()) {
                    endValid = true;
                }

                if (startValid && endValid) {
                    bookingValid = true;
                    break;
                }

            }


        }

        if (!bookingValid) {
            openRuleErrors.add("Please choose a valid slot!");
        }

        return openRuleErrors;
    }

    //used to check if a booking is within the bounds set by the open rule
    private ArrayList<String> withinOpenRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> openRuleErrors = new ArrayList<String>();
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);

        boolean bookingValid = false;

        for (Object o : openRuleList) {
            OpenRule openRule = (OpenRule) o;
            if (openRule.getDayOfWeek() == startBookingTime.getDay()) {
                Date openStart = openRule.getStartTime();
                Date openEnd = openRule.getEndTime();

                boolean startValid = false;
                boolean endValid = false;

                if (startBookingTime.getHours() > openStart.getHours()) {
                    startValid = true;
                } else if (openStart.getHours() == startBookingTime.getHours() && startBookingTime.getMinutes() >= openStart.getMinutes()) {
                    startValid = true;
                }

                if (endBookingTime.getHours() < openEnd.getHours()) {
                    endValid = true;
                } else if (openEnd.getHours() == endBookingTime.getHours() && endBookingTime.getMinutes() < openEnd.getMinutes()) {
                    endValid = true;
                }

                if (startValid && endValid) {
                    bookingValid = true;
                    break;
                }

            }


        }

        if (!bookingValid) {
            openRuleErrors.add("The facility is closed at the time you have selected!");
        }

        return openRuleErrors;
    }

    private ArrayList<String> validateCloseRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> closeRuleErrors = new ArrayList<String>();
        ArrayList<CloseRule> closeRuleList = rDAO.getAllCloseRule(facilityTypeID);

        for (Object o : closeRuleList) {
            CloseRule closeRule = (CloseRule) o;

            //if the start of booking falls between the start of the closed time and end of it
            if (closeRule.getStartDate().before(startBookingTime) && closeRule.getEndDate().after(startBookingTime)) {
                closeRuleErrors.add("Sorry, the facility is closed on that day.");
                //if the end of the booking falls between the start of the closed time and end of it
            } else if (closeRule.getStartDate().before(endBookingTime) && closeRule.getEndDate().after(endBookingTime)) {
                closeRuleErrors.add("Sorry, the facility is closed on that day.");
            } else if (closeRule.getStartDate().after(startBookingTime) && closeRule.getEndDate().before(endBookingTime)) {
                closeRuleErrors.add("Sorry, the facility is closed on that day.");
            }
        }

        return closeRuleErrors;

    }

    private ArrayList<String> validateLimitRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> limitRuleErrors = new ArrayList<String>();
        ArrayList<LimitRule> limitRuleList = rDAO.getAllLimitRule(facilityTypeID);
        uDAO = new UserDAO();


        User user = uDAO.getUser(userID);
        int block = user.getBlock().getId();
        int unit = user.getUnit();
        int level = user.getLevel();
        ArrayList<Booking> unitBookingList = bDAO.getUnitBookings(block, unit, level);
        System.out.println("BOOKINGRETRIEVED:" + unitBookingList.size());
        System.out.println("LIMITRULELISTSIZE:" + limitRuleList.size());
        System.out.println("Block:" + block);
        System.out.println("Unit:" + unit);
        System.out.println("Level:" + level);
        for (Object o : limitRuleList) {
            LimitRule limitRule = (LimitRule) o;
            String timeFrametype = limitRule.getTimeframeType();
            System.out.println("TIMEFRAMETYPE:" + timeFrametype);
            int sessions = limitRule.getSessions();
            int numberOfTimeframe = limitRule.getNumberOfTimeframe();
            int count = 0;
            Calendar bookingDate = Calendar.getInstance();
            bookingDate.setTime(startBookingTime);

            Calendar checkDate = Calendar.getInstance();
            System.out.println(checkDate.get(Calendar.MONTH));
            for (Booking booking : unitBookingList) {
                System.out.println("CheckONE");
                if (booking.getFacility().getFacilityType().getId() == facilityTypeID) {
                    System.out.println("CheckTWO");
                    if (!booking.getIsDeleted()) {
                        System.out.println("CheckTHREE");
                        checkDate.setTime(booking.getStartDate());
                        if (timeFrametype.equals("DAY")) {
                            if (bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR)) {
                                int bookingDay = bookingDate.get(Calendar.DAY_OF_YEAR);
                                int checkDay = checkDate.get(Calendar.DAY_OF_YEAR);
                                //this checks to see if the day is within the day limits
                                if (Math.abs(checkDay - bookingDay) < numberOfTimeframe) {
                                    count++;
                                }

                            } else if (bookingDate.get(Calendar.DAY_OF_YEAR) < numberOfTimeframe
                                    && bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR) - 1) {
                                int checkDay = checkDate.get(Calendar.DAY_OF_YEAR) - 365;
                                int bookingDay = bookingDate.get(Calendar.DAY_OF_YEAR);
                                if (Math.abs(checkDay - bookingDay) < numberOfTimeframe) {
                                    count++;
                                }
                            }

                        } else if (timeFrametype.equals("WEEK")) {
                            if (bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR)) {
                                int bookingWeek = bookingDate.get(Calendar.WEEK_OF_YEAR);
                                int checkWeek = checkDate.get(Calendar.WEEK_OF_YEAR);

                                if (Math.abs(checkWeek - bookingWeek) < numberOfTimeframe) {

                                    count++;
                                }


                            } else if (bookingDate.get(Calendar.WEEK_OF_YEAR) < numberOfTimeframe
                                    && bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR) - 1) {
                                int checkWeek = checkDate.get(Calendar.WEEK_OF_YEAR) - 52;
                                int bookingWeek = bookingDate.get(Calendar.WEEK_OF_YEAR);
                                if (Math.abs(checkWeek - bookingWeek) < numberOfTimeframe) {
                                    count++;
                                }
                            }
                        } else if (timeFrametype.equals("MONTH")) {
                            System.out.println("IGOTTOMONTH");

                            if (bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR)) {
                                int bookingMonth = bookingDate.get(Calendar.MONTH);
                                int checkMonth = checkDate.get(Calendar.MONTH);

                                if (Math.abs(checkMonth - bookingMonth) < numberOfTimeframe) {

                                    count++;
                                }


                            }
                        } else if (timeFrametype.equals("YEAR")) {
                            if (bookingDate.get(Calendar.YEAR) == checkDate.get(Calendar.YEAR)) {
                                int bookingYear = bookingDate.get(Calendar.YEAR);
                                int checkYear = checkDate.get(Calendar.YEAR);
                                if (Math.abs(checkYear - bookingYear) < numberOfTimeframe) {
                                    count++;
                                }


                            }
                        }
                    }


                    if (count >= sessions) {
                        limitRuleErrors.add("You have reached the maximum booking limit for the duration.");
                        System.out.println("LIMITRULEERRORS:" + limitRuleErrors.size());
                        break;
                    }
                }
            }
        }
        return limitRuleErrors;
    }

    private ArrayList<String> validateAdvanceRule(int userID, int facilityTypeID, Date startBookingTime, Date endBookingTime) {

        ArrayList<String> advanceRuleErrors = new ArrayList<String>();
        ArrayList<AdvanceRule> advanceRuleList = rDAO.getAllAdvanceRule(facilityTypeID);


        for (Object o : advanceRuleList) {
            AdvanceRule advanceRule = (AdvanceRule) o;
            Date currentDate = new Date();
            long currentTime = currentDate.getTime();
            long startTime = startBookingTime.getTime();
            long daysBetween = getMillisecondsToDay(startTime - currentTime);
            if (daysBetween > advanceRule.getMinDays()) {
                advanceRuleErrors.add("Sorry, the facility allows you to book a maximum of " + advanceRule.getMinDays() + " days in advance.");
            } else if (daysBetween < advanceRule.getMaxDays()) {
                advanceRuleErrors.add("Sorry, you need to book the facility at least " + advanceRule.getMaxDays() + " days in advance.");
            }


        }

        return advanceRuleErrors;

    }

    private ArrayList<String> validateClash(Facility facility, Date startBookingTime, Date endBookingTime) {
        ArrayList<String> clashErrors = new ArrayList<String>();
        ArrayList<Booking> bookings = bDAO.getBookingByPeriod(startBookingTime, endBookingTime, facility);

        if (!bookings.isEmpty()) {
            clashErrors.add("Your booking clashes with another booking. Please try again.");
        }


        return clashErrors;

    }

    public ArrayList<String> getFacilityOpeningTime(int facilityTypeID, int dayOfWeek) {
        ArrayList<String> openTimes = new ArrayList<String>();
        ArrayList<OpenRule> openRuleList = rDAO.getAllOpenRule(facilityTypeID);
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        for (OpenRule o : openRuleList) {
            if (o.getDayOfWeek() == dayOfWeek) {
                String startString = sdf.format(o.getStartTime());
                String endString = sdf.format(o.getEndTime());
                openTimes.add(startString + "," + endString);
            }

        }

        return openTimes;
    }

    private long getDayToMilliseconds(int i) {
        return i * 1000 * 60 * 60 * 24;
    }

    private long getMillisecondsToDay(long i) {
        return i / 1000 / 60 / 60 / 24;
    }

    public OpenRule.DAY_OF_WEEK getOpenRuleDayOfWeekByDayIndex(int index) {
        switch (index) {
            case 0:
                return OpenRule.DAY_OF_WEEK.SUNDAY;
            case 1:
                return OpenRule.DAY_OF_WEEK.MONDAY;
            case 2:
                return OpenRule.DAY_OF_WEEK.TUESDAY;
            case 3:
                return OpenRule.DAY_OF_WEEK.WEDNESDAY;
            case 4:
                return OpenRule.DAY_OF_WEEK.THURSDAY;
            case 5:
                return OpenRule.DAY_OF_WEEK.FRIDAY;
            case 6:
                return OpenRule.DAY_OF_WEEK.SATURDAY;
        }
        return null;
    }
}
