package hudson.plugins.hadoop;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import hudson.remoting.Callable;

import org.apache.hadoop.mapred.JobStatus;
import org.apache.hadoop.mapred.JobTracker;
import org.apache.hadoop.mapred.TaskReport;

class JobTrackerQueryTask implements Callable<Object,Exception> {

	public Object call() throws Exception {
		JobTracker tracker = ServiceRepository.getInstance().getJobTracker();
		Map<String, Object> jobTrackerMap = PropertyInspector.inspect(tracker);
		return addDetailedJobInfo(tracker, jobTrackerMap);
		// return jobTrackerMap;
	}
	
	private Object addDetailedJobInfo(JobTracker tracker, Map<String, Object> jobTrackerMap) {
		List<Map<String, Object>> jobsMap = new ArrayList<Map<String, Object>>();
		for(JobStatus jobStatus : tracker.getAllJobs()) {
			Map<String, Object> jobMap = PropertyInspector.inspect(jobStatus);
			
			// Map TaskReport
			jobMap.put("mapProgress", jobStatus.mapProgress());
//			List<Map<String, Object>> mapTasks = new ArrayList<Map<String, Object>>();
//			for(TaskReport mapTaskReport : tracker.getMapTaskReports(jobStatus.getJobID())) {
//				mapTasks.add(PropertyInspector.inspect(mapTaskReport));
//			}
//			jobMap.put("mapTaskReport", mapTasks);
//			
//			// Reduce TaskReport
			jobMap.put("reduceProgress", jobStatus.reduceProgress());
//			List<Map<String, Object>> reduceTasks = new ArrayList<Map<String, Object>>();
//			for(TaskReport reduceTaskReport : tracker.getReduceTaskReports(jobStatus.getJobID())) {
//				reduceTasks.add(PropertyInspector.inspect(reduceTaskReport));
//			}
//			jobMap.put("reduceTaskReport", reduceTasks);
			
			jobsMap.add(jobMap);
		}
		jobTrackerMap.put("jobs", jobsMap);
		
		return jobTrackerMap;
	}

	private static final long serialVersionUID = 1L;
}
