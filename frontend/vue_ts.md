> vue 项目搭建

- [webpack环境配置](#webpack环境配置)
- [配置TS环境](#配置TS环境)
- [配置Dev环境](#配置Dev环境)
- [配置webpack实用工具](#配置webpack实用工具)



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
- 配置打包命令`package.json`

```json
{
 "scripts": {
     "build": "webpack"
   } 
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

#### 配置Dev环境
- 安装依赖
```json
{
 "webpack-dev-server": "^3.11.2"
}
```
- 配置`webpack.config.js`
```javascript
const webpack = require('webpack');
module.exports = {
  plugins: [
    new webpack.HotModuleReplacementPlugin()  
  ],
  devServer: {
        port: 8080,
        open: true,
        host: 'localhost',
        hot: true, // 开启热更新
        contentBase: path.join(__dirname, 'dist'),
        writeToDisk: true, // 在开发模式下可以将内存中的文件输出到磁盘
        // proxy: {
        //     '/': {
        //         target:'http://localhost:300',
        //         changeOrigin: true
        //     }
        // }
    }
}
```

- 配置打包命令`package.json`

```json
{
 "scripts": {
     "dev": "webpack serve"
   } 
}
```
- 输入命令`yarn dev`打包成功
#### 配置`webpack`实用工具
> 以下提供了一些插件的功能以及介绍，具体配置需要到`npm`上面进行足以查找
- 实用插件列表
    - `html-webpack-plugin`：用于将`index.html`放到`dist`文件里面去
    - `clean-webpack-plugin` ：可以在`dev`模式下将在代码改变后将某个文件夹删除掉
    - `copy-webpack-plugin`：可以将一些静态资源拷贝到指定的目录下
    - `mini-css-extrac-plugin`：可以将css抽离出来成为一个独立的文件，但是该插件不能
    配合`webpack`的热更新使用，所以在`dev`模式下的`css`插件使用`style-loader`，在
    生产环境下使用`mini-css-extract-plugin`抽取`css`
    - `optimize-css-assets-webpack-plugin`：由于`mini-css-extract-plugin`抽离
    出来的`css`是没有经过压缩，所以有时候一些三方库的`css`文件比较大，导致网络延迟比较高，
    这里使用该插件达到压缩`css`目的
    - `webpack`：使用`webpack`原生自带的插件，里面有几个插件项目可能用的上的
        - `webpack.DefinePlugin()`
        - `webpack.HotModuleReplacementPlugin`
- 实用`loader`列表