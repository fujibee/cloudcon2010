/*
 * The MIT License
 *
 * Copyright (c) 2004-2009, Sun Microsystems, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package hudson.plugins.hadoop;

import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.TaskTracker;

import java.io.File;
import java.io.IOException;

/**
 * Starts a {@link TaskTracker}.
 */
class TaskTrackerStartTask extends SlaveTask {
    private final String jobTrackerAddress;

    TaskTrackerStartTask(String hdfsUrl, String rootPath, String address, String jobTrackerAddress) {
        super(hdfsUrl, rootPath, address);
        this.jobTrackerAddress = jobTrackerAddress;
    }

    public Void call() throws IOException {
        System.out.println("Starting data node");

        JobConf conf = new JobConf();
        conf.set("fs.default.name",hdfsUrl);
        conf.set("mapred.job.tracker",jobTrackerAddress);
        conf.set("mapred.task.tracker.http.address","0.0.0.0:0");
        conf.set("mapred.task.tracker.report.address","0.0.0.0:0");
        conf.set("mapred.local.dir",new File(new File(rootPath),"hadoop/task-tracker").getAbsolutePath());
        conf.set("slave.host.name", slaveHostName);

        new Thread(new TaskTracker(conf)).start();

        return null;
    }

    private static final long serialVersionUID = 1L;
}
