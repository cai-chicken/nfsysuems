package com.nfsysu.ems.dao;

import java.util.List;
import java.util.Map;

import com.nfsysu.ems.entity.User;

/**
 * 用户Dao接口
 * @author 小海
 *
 */
public interface UserDao {
	public int register(User user);

	/**
	 * 获取登录的用户
	 * @param user
	 * @return
	 */
	public User login(User user);
	
	/**
	 * 查询用户集合
	 * @param map
	 * @return
	 */
	public List<User> find(Map<String,Object> map);
	
	/**
	 * 获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String,Object> map);

	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	public int update(User user);
	
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int add(User user);
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	
	/**
	 * 根据id查找实体
	 * @param id
	 * @return
	 */
	public User findById(Integer id);

	public User getByUserName(String userName);

	public User existNum(User user);
	
}
