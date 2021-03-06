package com.lgcns.tec.cache.redis.test;

import java.io.Serializable;

public class SampleVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String name;
    public String value;
    
    /**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

}
