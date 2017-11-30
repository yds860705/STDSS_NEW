package com.stdss.utils;

public class standard {
	 public static double mean(double[] array) {  
		    double sum = 0.0;

		    for (int i = 0; i < array.length; i++)
		      sum += array[i];

		    return sum / array.length;
		  }

	public static double standardDeviation(double[] array, int option) {
		    if (array.length < 2) return Double.NaN;

		    double sum = 0.0;
		    double sd = 0.0;
		    double diff;
		    double meanValue = mean(array);

		    for (int i = 0; i < array.length; i++) {
		      diff = array[i] - meanValue;
		      sum += diff * diff;
		    }
		    sd = Math.sqrt(sum / (array.length - option));

		    return sd;
		  }
	public static double norm(double x,double mu,double sa){
		return (-(x-mu)/sa);
	}

	public static double tsocre(double x){
		return ((x*15)+70);
	}
	
	
	

		}
