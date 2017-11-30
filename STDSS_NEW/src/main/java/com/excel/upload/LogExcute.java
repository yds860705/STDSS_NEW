package com.excel.upload;
import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogExcute  {
	
	public void before(JoinPoint j)
			throws Throwable {
		Logger log = LoggerFactory.getLogger(j.getTarget()+"");
		log.debug("start");
		
		Object args[]=j.getArgs();
		
		if(args!=null){
			log.debug("method:\t"+j.getSignature().getName());
			for (int i = 0; i < args.length; i++) {
				log.debug(i+"th:\t"+args[i]);
			}
			log.debug("method:\t"+j.getSignature().getName());
		}

	}
	
	public void afterReturning(JoinPoint j) throws Throwable {
		Logger log = LoggerFactory.getLogger(j.getTarget()+"");
		log.debug("end");
	}
	
	public void daoError(JoinPoint j){
		Logger log = LoggerFactory.getLogger(j.getTarget()+""+j.getKind());
		log.debug("error"+j.getArgs( ));
		log.debug("error"+j.toString());
	}

}
