package com.lgcns.tec.cache.redis;

import com.lgcns.tec.cache.redis.config.RedisClientConfig;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.JedisShardInfo;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;
import redis.clients.util.Hashing;

public class Redis {
	
    private static JedisPool jedisPool = null;
    private static JedisPool sentinelPool = null;
	private static ShardedJedisPool shardedJedisPool = null;
	private static JedisPoolConfig redisConf = null;
    private static RedisClientConfig rcc = null;
    
    public static synchronized void createPool()
    {
    	if( rcc == null ) rcc = new RedisClientConfig();
    	rcc.loadConfig();
    	
    	if ( jedisPool == null ) createPool ( rcc.getServerHost(), rcc.getServerPort() ); //  jedisPool = new JedisPool(redisConf, rcc.getServerHost(), rcc.getServerPort());
    }
    
    public static synchronized void createPool( String host, int port )
    {
    	// get bind config from conf file
    	if (redisConf == null) redisConf = new JedisPoolConfig();
    	
    	if ( jedisPool == null ) jedisPool = new JedisPool(redisConf, host, port );
    	System.out.println( "Jedis Pool Hash Code : " + jedisPool.hashCode() );
    }
    
    public static void releasePool()
    {
    	if( jedisPool != null ) try { jedisPool.close(); } catch (Exception e) {}
    	jedisPool = null;
    }
    
    
    public static Jedis getInstance( String host, int port  )
    {
	    if( jedisPool == null ) createPool( host, port ); // jedisPool = new JedisPool(new JedisPoolConfig(), "localhost");
		   
	    return jedisPool.getResource();    	
    }
    
    public static Jedis getInstance()
    {
	    if( jedisPool == null ) createPool(); // jedisPool = new JedisPool(new JedisPoolConfig(), "localhost");
	   
	    return jedisPool.getResource();
    }
    
    public static synchronized void createShardedPool()
    {
    	//if( rcc == null ) rcc = new RedisClientConfig();
    	if( rcc == null ) rcc = RedisClientConfig.getInstance();
    	
    	rcc.loadConfig();
    	rcc.printConfig();
    	
    	 if ( shardedJedisPool == null ) shardedJedisPool = new ShardedJedisPool(new JedisPoolConfig(), rcc.getMasterServerList(), Hashing.MD5);
    	// if ( shardedJedisPool == null ) shardedJedisPool = new ShardedJedisPool(new JedisPoolConfig(), rcc.getMasterServerList() );
    	// if ( shardedJedisPool == null ) shardedJedisPool = new ShardedJedisPool(new JedisPoolConfig(), rcc.getMasterServerList(), new JumpHash(rcc.getMasterServerList().size()) );
    }
    
    public ShardedJedisPool getShardedPool()
    {
    	return shardedJedisPool;
    }
    
    public static ShardedJedis getShardedInstance( )
    {
    	if ( shardedJedisPool == null ) createShardedPool();    	
    	//if ( shardedJedisPool == null ) return null;
    	
    	return shardedJedisPool.getResource();
    }
    
    public static synchronized void createSentinelPool()
    {
    	// get bind config from conf file
    	if (redisConf == null) redisConf = new JedisPoolConfig();
    	
    	if( rcc == null ) rcc = new RedisClientConfig();
    	rcc.loadConfig();
    	
    	JedisShardInfo jsi = rcc.getSentinelServerList().get(0);
    	System.out.println( jsi.getHost() );
    	System.out.println( jsi.getPort() );
    	if ( sentinelPool == null ) sentinelPool = new JedisPool(redisConf, jsi.getHost(), jsi.getPort());    
    }
    
    public static Jedis getSentinel()
    {
	    if( sentinelPool == null ) createSentinelPool(); // jedisPool = new JedisPool(new JedisPoolConfig(), "localhost");
	   
	    return sentinelPool.getResource();
    }
    
    public static void releaseSentinelPool()
    {
    	if( sentinelPool != null ) try { sentinelPool.close(); } catch (Exception e) {}
    }
    
    
}
