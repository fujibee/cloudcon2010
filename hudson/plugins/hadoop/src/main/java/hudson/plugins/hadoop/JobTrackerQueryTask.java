package hudson.plugins.hadoop;

import java.util.HashMap;
import java.util.Map;

import org.apache.hadoop.mapred.ClusterStatus;
import org.apache.hadoop.mapred.JobTracker;

import hudson.remoting.Callable;

class JobTrackerQueryTask implements Callable<Object,Exception> {

	private JobTracker tracker;

	public Object call() throws Exception {
		tracker = ServiceRepository.getInstance().getJobTracker();
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("clusterStatus", clusterStatusToMap());
		
		return result;
	}

	private Map<String, Object> clusterStatusToMap() {
		ClusterStatus cs = tracker.getClusterStatus();
		Map<String, Object> csMap = new HashMap<String, Object>();
		csMap.put("mapTasks", cs.getMapTasks());
		csMap.put("reduceTasks", cs.getReduceTasks());
		csMap.put("maxMapTasks", cs.getMaxMapTasks());
		csMap.put("maxReduceTasks", cs.getMaxReduceTasks());
		return csMap;
	}

	private static final long serialVersionUID = 1L;
}
