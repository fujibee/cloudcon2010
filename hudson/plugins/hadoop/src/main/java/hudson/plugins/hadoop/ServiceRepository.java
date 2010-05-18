package hudson.plugins.hadoop;

import org.apache.hadoop.hdfs.server.namenode.NameNode;
import org.apache.hadoop.mapred.JobTracker;

class ServiceRepository {
	/* job tracker */
	static JobTracker tracker;
	
	/* name node service (not implemented) */
	static NameNode nameNode;
}
