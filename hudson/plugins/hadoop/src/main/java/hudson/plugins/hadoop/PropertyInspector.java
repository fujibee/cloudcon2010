package hudson.plugins.hadoop;

import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;

public class PropertyInspector {

	static Map<String, Object> inspect(Object obj) {
		Map<String, Object> result = new HashMap<String, Object>();
		for (PropertyDescriptor descriptor : PropertyUtils.getPropertyDescriptors(obj)) {
			String key = descriptor.getName();
			Object value = null;
			try {
				value = descriptor.getReadMethod().invoke(obj);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//System.out.println("key=" + key + " value=" + value);
			if (value == null) continue;
			// 1. array
			if (value instanceof Collection<?> || value.getClass().isArray()) {
				List<Map<String, Object>> resultArr = new ArrayList<Map<String, Object>>();
				List<Object> valueAsArr = Arrays.asList(value);
				for (Object aValue : valueAsArr) {
					resultArr.add(inspect(aValue));
				}
				result.put(key, resultArr);
			
			// 2. non-primitive
			} else if (!isReaf(value)) {
				if (!isHadoopClass(value)) continue;
				result.put(key, inspect(value));
				
			// 3. primitive
			} else {
				result.put(key, value);
			}
		}
		return result;
	}

	private static boolean isHadoopClass(Object value) {
		if (value.getClass().getPackage().getName().indexOf("org.apache.hadoop") >= 0) {
			return true;
		}
		System.out.println(value.getClass().toString() + " is not hadoop class.");
		return false;
	}

	private static boolean isReaf(Object obj) {
		//System.out.println("class=" + obj.getClass());
		if (!(obj instanceof Serializable) || obj instanceof Collection<?> || obj.getClass().isArray())
			return false;
		Class<?>[] reafClasses = { String.class, Boolean.class,
				Character.class, Byte.class, Short.class, Integer.class,
				Long.class, Float.class, Double.class };
		for (Class<?> cls : reafClasses) {
			if (cls.equals(obj.getClass())) return true;
		}
		return false;
	}

}
