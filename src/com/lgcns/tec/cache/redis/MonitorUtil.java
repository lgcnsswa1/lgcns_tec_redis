package com.lgcns.tec.cache.redis;

import java.util.List;

import redis.clients.jedis.Jedis;

public class MonitorUtil {
    public static void getClusterInfo()
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    String clusterStat = jedisInst.clusterInfo();
		    
		    System.out.println(clusterStat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }
    public static void getInfo()
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    String stat = jedisInst.info();
		    
		    //System.out.println(stat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }
    
    public static String getInfoBySection(Jedis jedisInst, String section)
    {
    	String stat = null;
    	
    	try {
	    	stat = jedisInst.info(section);
		    
		    //System.out.println(stat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		}  
    	
    	return stat;
    }
    
    public static String getInfoBySection(String section)
    {
    	Jedis jedisInst = null;
    	String stat = null;
    	
    	try {
	    	jedisInst = Redis.getInstance();

		    stat = jedisInst.info(section);
		    
		    //System.out.println(stat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    	
    	return stat;
    }
    
    
    public static String getInfoByParam(Jedis jedisInst, String param)
    {
    	String value[] = null;
    	
    	try {
		    String stat[] = jedisInst.info().split(param);
		    value = stat[1].split(":");
		    value = value[1].split("\n");
		    
		    System.out.println(value[0]);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} 
    	
    	return value[0];
    }
    
    public static String getInfoByParam(String param)
    {
    	Jedis jedisInst = null;
    	String value[] = null;
    	
    	try {
	    	jedisInst = Redis.getInstance();

		    String stat[] = jedisInst.info().split(param);
		    value = stat[1].split(":");
		    value = value[1].split("\n");
		    
		    System.out.println(value[0]);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    	
    	return value[0];
    }
    
    public static void shutdownRedis()
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    String log = jedisInst.shutdown();
		    if(log==null){
		    	System.out.println("Redis server has been shut down ");
		    }
		    else{
		    	System.out.println("The following error occurred during shutdown.");
			    System.out.println("The error code is "+log);
		    }

		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }
    
    public static void getConfig()
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    List<String> stat = jedisInst.configGet("*");
		    
		    System.out.println(stat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }

    /**
     * 
     */
    
    public static void getConfigWithParam(String param)
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    List<String> stat = jedisInst.configGet(param);
		    
		    System.out.println(stat);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }
    
    
    public static void setConfigWithParam(String param, String value)
    {
    	Jedis jedisInst = null;
    	try {
	    	jedisInst = Redis.getInstance();

		    jedisInst.configSet(param, value);
		    
		    System.out.println(param+" has been set to "+value);
		    
//		    getConfigWithParam(param);
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jedisInst.close();
		} 
    }
}
