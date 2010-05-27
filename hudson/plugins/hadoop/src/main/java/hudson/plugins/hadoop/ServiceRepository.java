package hudson.plugins.hadoop;

import org.apache.hadoop.hdfs.server.namenode.NameNode;
import org.apache.hadoop.mapred.JobTracker;

class ServiceRepository {
	
	/* singleton instance */
	private static ServiceRepository instance = new ServiceRepository();
	
	/* job tracker */
	private JobTracker jobTracker;
	
	/* name node service (not implemented) */
	private NameNode nameNode;

	static ServiceRepository getInstance() {
		return instance;
	}
	
	void setJobTracker(JobTracker jt) {
		this.jobTracker = jt;
	}
	
	JobTracker getJobTracker() {
		return this.jobTracker;
	}
	
	void setNameNode(NameNode nn) {
		this.nameNode = nn;
	}
	
	NameNode getNameNode() {
		return this.nameNode;
	}
	
	private ServiceRepository() { // do nothing
	}
}
