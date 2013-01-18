/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lin.comparators;

import com.lin.entities.OpenRule;
import java.util.Comparator;

/**
 *
 * @author Yangsta
 */
public class SortOpenRuleByDayOfWeekComparator implements Comparator<OpenRule> {
    
    public int compare(OpenRule o1, OpenRule o2) {
        return o1.getDayOfWeek() - o2.getDayOfWeek();
    }

}
