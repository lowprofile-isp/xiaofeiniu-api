/**
 * 小肥牛扫码点餐项目API子系统
 */
const PORT = 8090;
// const PORT = 5050;
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const categoryRouter = require('./routes/admin/category');
const loginRouter = require('./routes/admin/admin');
const dishRouter = require('./routes/admin/dish');
const settingsRouter = require('./routes/admin/settings');
const tableRouter = require('./routes/admin/table');

// 创建HTTP应用服务器
// 启动主服务器
var app = express();

// 使用中间件
// 解决跨域
app.use(cors({
	origin:'*'
}))
// app.use(bodyParser.urlencoded({}))	//把application/x-www-form-urlencoded格式的请求主体数据
app.use(bodyParser.json());//把application/JSON格式的请求主体数据解析出来放入req.body属性

app.listen(PORT,()=>{
	console.log('Server Listening'+PORT+'...');
	console.log(new Date().toLocaleDateString());
	console.log('API服务器启动成功...');
})

// 挂载路由器
app.use('/admin/category',categoryRouter);
app.use('/admin',loginRouter);
app.use('/admin/dish',dishRouter);
app.use('/admin/settings',settingsRouter);
app.use('/admin/table',tableRouter);