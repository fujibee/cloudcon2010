package hudson.plugins.hadoop;

import hudson.remoting.Callable;

import org.apache.hadoop.mapred.JobTracker;

class JobTrackerQueryTask implements Callable<Object,Exception> {

	public Object call() throws Exception {
		JobTracker tracker = ServiceRepository.getInstance().getJobTracker();
		return PropertyInspector.inspect(tracker);
	}

	private static final long serialVersionUID = 1L;
}
