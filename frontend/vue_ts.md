> vue 项目搭建

[webpack环境配置](#webpack环境配置)





#### webpack环境配置

- 安装依赖

```javascript
  "devDependencies": {
    "webpack": "^5.3.0",
    "webpack-cli": "^4.5.0"
  }
```

- 配置入口文件`webpack.config.js`

```javacript
const path = require('path');
module.exports = {
    entry: './src/index.js',
    mode: 'production',
    output: {
        path: path.resolve(__dirname, 'dist')
    }
}
```

- 创建入口文件`src/index.js`
- 配置打包命令

```javacript
  "scripts": {
    "build": "webpack"
  }
```

- 配置完成，运行命令`yarn build`