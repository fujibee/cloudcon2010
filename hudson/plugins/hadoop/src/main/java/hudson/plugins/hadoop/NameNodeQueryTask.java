package hudson.plugins.hadoop;

import hudson.remoting.Callable;

import org.apache.hadoop.hdfs.server.namenode.NameNode;

class NameNodeQueryTask implements Callable<Object,Exception> {

	public Object call() throws Exception {
		NameNode nameNode = ServiceRepository.getInstance().getNameNode();
		return PropertyInspector.inspect(nameNode);
	}

	private static final long serialVersionUID = 1L;
}
