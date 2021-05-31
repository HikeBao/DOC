> vue 项目搭建

[webpack环境配置](#webpack环境配置)
[配置TS环境](#配置TS环境)




#### webpack环境配置

- 安装依赖

```json
{
  "devDependencies": {
    "webpack": "^5.3.0",
    "webpack-cli": "^4.5.0"
  }}
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
- 添加`.gitignore`文件,将`.idea`、`.vscode`、`dist`、`node_modules`、`yarn-error.log`等文件添加进去

#### 配置TS环境
- 安装依赖

```json
{
 "devDependencies": {
     "ts-loader": "^9.2.2",
    "typescript": "^4.3.2"
  }
}
```

- 配置`webpack.config.js`
```javascript
module.export = {
    entry: './src/index.ts',
    resolve: {
        // 不加上的话会报解析错误 Module not found: Error: Can't resolve './test'
        extensions: ['.js', '.ts']
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                loader: 'ts-loader'
            }
        ]
    }
}
```
- 创建`tsconfig.json`并加入以下配置
```json
{
  "compilerOptions": {
    "moduleResolution": "node",
    "jsx": "preserve"
  },
  "include": ["src/**/*"]
}
```
- 运行命令`yarn build`， 打包成功