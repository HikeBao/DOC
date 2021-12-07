> vue 项目搭建

- [webpack环境配置](#webpack环境配置)
- [配置TS环境](#配置TS环境)
- [配置Dev环境](#配置Dev环境)
- [配置webpack实用工具](#配置webpack实用工具)



#### webpack环境配置

- [ECMA-New](./ecma/ecma-new.md)

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
{ "scripts": {     "dev": "webpack serve"   } }
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





#### mode报错

```javascript
The 'mode' option has not been set, webpack will fallback to 'production' for this value. Set 'mode' option to 'development' or 'production' to enable defaults for each environment.

# 问题原因
由于webpack在打包的时候需要区分环境，所以需要一个模式来标识。这个表示一般系统在未配置的时候会发出警告并设置默认值为development。

# 解决方案
方案一：在package.json里面的scripts字段添加里面 --mode=development
"build": "webpack --mode=development"

方案二：在webpack.config.js里面添加一个mode字段
module.exports = {
	mode: 'development',
	entry: '***',
	output: {
		filename: '****'
	}
}
```



#### babel 报错

```javascript
- Maybe you meant to use
"plugins": [
  ["@babel/plugin-transform-runtime", {
  "corejs": 3
}]
]

# 问题原因
错误将corejs:3归纳为plugins的子项目，其实应该是和@babel/plugin-transform-runtime同级

# Tips
使用babel的时候会用到一大堆依赖
@babel/core
@babel/plugin-transform-runtime
@babel/preset-env
@babel/runtime
@babel/runtime-corejs3

# babel完整配置
  module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader",
                    options: {
                        "presets": ["@babel/preset-env"],
                        "plugins": [
                            ["@babel/plugin-transform-runtime", {
                                "corejs": 3
                            }]
                        ]
                    }
                }
            }]
    }

# 推荐版本
在webpack.config.js里面写
 module: {
        rules: [
            {
                test: /\.js$/,
                use: {
                    loader: "babel-loader"
                },
                 exclude: /node_modules/
            }]
    }
然后新建一个.babelrc目录负责维护babel的配置
{
    "presets": ["@babel/preset-env"],
        "plugins": [
            ["@babel/plugin-transform-runtime", {
                "corejs": 3
            }]
        ]
}
```



#### html-webpack-plugin 使用

```javascript
const HtmlWebpackPlugin = require('html-webpack-plugin');
module.exports = {
    plugins: [
        new HtmlWebpackPlugin({
            template: './index.html', // 获取模板的位置
            filename: 'index.html' // 类似output里面的filename
        })
    ]
}

# 进阶config
`创建一个htmlConfig.js配置文件，然后再里面写入需要开启的变量`
mudule.exports = {
    dev: {
        template: {
            title: 'hello',
            header: false,
            footer: false
        }
    },
    build: {
        template: {
            title: '大家好',
            header: true
        }
    }
}
`在webpack.config.js里面引入htmlConfig.js`
const isDev = process.env.NODE_ENV === 'development';
const config = require('./htmlConfig.js')[isDev ? 'dev' : 'build'];
module.exports = {
     plugins: [
        new HtmlWebpackPlugin({
            template: './index.html', // 获取模板的位置
            filename: 'index.html',   // 类似output里面的filename
            config: config.template
        })
    ]
}
`在html模板里面书写语句`
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= (htmlWebpackPlugin.options.config.title) %></title>
</head>
<body>
    <% if(htmlWebpackPlugin.options.config.header){ %>
    <header>我是头部</header>
    <% } %>
    <div id="app"></div>
    <% if(htmlWebpackPlugin.options.config.footer){ %>
    <footer>我是footer</footer>
    <% } %>
</body>
</html>
```



#### cross-env报错

```javascript
# 传递NODE_ENV
 - 可以通过set方式进行变量的设置 build: "set NODE_ENV=development" 在window下可以
 - 也可以通过cross-env方式 build: "cross-env NODE_ENV=development" 兼容linux和window
 
 # cross-env 不是内部或外部命令问题处理
 - 全局install cross-env
```



#### webpack-dev-server

```javascript
# 原来在webpack.config.js里面的devServer是搭配webpack-dev-server来用的
一般在开发环境使用，所以，里面一般会有那种是否自动打开浏览器的设置(oepn)
设置端口号，是否代理，host等等
```



#### 处理css

```javascript
style-loader: 动态创建style标签，将css插入到head中
css-loader：负责处理@import等语句
postcss-loader和autoprefixer：自动生成浏览器兼容性前缀
less-loader：负责处理编译.less文件，将其转为css

# 在webpack.config.js中的完整配置
module.exports = {
    module: {
        rules: [
              {
                test: /\.less$/,
                use: [
                    'style-loader', 'css-loader', {
                        loader: 'postcss-loader',
                        options: {
                            plugins () {
                                return [
                                    require('autoprefixer')({
                                        "overrideBrowserslist": [
                                            ">0.05%",
                                            "not dead"
                                        ]
                                    })
                                ]

                            }
                        }
                    },
                    'less-loader'
                ]
            }
        ]
    }
}
其中use字段的loader执行顺序是从右往左的

# 将部分配置写到package.json里面去
  "browserslist": [
    ">0.25%",
    "not dead"]
然后只要在postcss-loader那个地方引入autoprefixer就行
use: [
    'style-loader', 'css-loader',
    {
        loader: 'postcss-loader',
        options: {
            plugins: [require('autoprefixer')]
        }
    },
    'less-loader'
]
```

## 目录

- [构建流程](#webpack构建流程)
- [loader&plugin](#和不同之处)
- [关于配置](#关于配置)

#### `webpack`构建流程

```javascript
- 开始编译：从配置文件和shell语句中读到的参数合并初始化complier对象，加载所有配置的插件，执行run方法开始编译
- 编译模块，从入口文件出发，调用所有配置的loader对模块进行解析翻译，在找到该模块依赖的模块进行处理
- 输出资源，根据入口和模块之间的依赖关系，组装成一个个包含多个模块的chunk，在把每个chunk转换成一个单独的文件加载到输出列表
```



#### 什么是`bundle`,什么是`chunk`,什么是`module`

- bundle：用webpack打包出来的文件

- chunk：webpack在进行模块的依赖分析的时候，分割出来的代码块。

  >  require.ensure(['./a'], require => {
  >   // 这里是需要对引入的模块执行的操作
  >  });

- module：开发中的单个模块



#### `loader`和`plugin`不同之处

```javascript
# 区别
- loader是webpack拥有加载和解析非js文件的能力，它会告诉webpack在require或者import的语句中被解析为'.xxx'的路径时，在对其打包前，先使用'xxx-loader转换一下'；
- plugin可以扩展webpack的功能，使得webpack更加灵活。在 webpack 的事件流中执行对应的方法。

# 几个常见的loader
- file-loader：把文件输出到一个文件夹中，在代码中通过相对 URL 去引用输出的文件
- url-loader：和 file-loader 类似，但是能在文件很小的情况下以 base64 的方式把文件内容注入到代码中去
- source-map-loader：加载额外的 Source Map 文件，以方便断点调试（这个在webpack5之后就直接内置在配置里面soruceMap）
- image-loader：加载并且压缩图片文件
- babel-loader：把 ES6 转换成 ES5
- css-loader：加载 CSS，支持模块化、压缩、文件导入等特性
- style-loader：把 CSS 代码注入到 JavaScript 中，通过 DOM 操作去加载 CSS。
- eslint-loader：通过 ESLint 检查 JavaScript代码

# 几个常见的plugin
// 先引入const A = require(xxx)，然后new A()
- define-plugin：定义环境变量
- terser-webpack-plugin：通过TerserPlugin压缩ES6代码
- html-webpack-plugin 用于生成index.html于dist文件里面
- mini-css-extract-plugin：分离css文件至一个单文件里面
- clean-webpack-plugin：删除打包文件
- happypack：实现多线程加速编译
- Open-Browser-Plugin：打开浏览器 npm run dev
```



#### 关于配置

- 写在`webpack.config.js`会覆盖`package.json`里面的配置 以下简称config

- `entry` & `ouput`

  > entry和output，其中entry的值可以为一个对象(也可以为一个string类型)，key为输出的包名，value为具体资源的位置，output目前知道值为Object类型，定义输出的文件名是通过key(filename)，value则是`[name].js`来定义输入什么名字输出就是什么名字
  >
  > - module为第三项，主要用于匹配那些不是原生`js、css、html、img`，然后将其转化为`js、css、img、html`.在module里面有一个配置项，是rules(Array数据类型),用于配置各种资源。Ex：`{test: /\.css$/, use: ['style-loader', 'css-loader']}`，而且use里面可以为数组也可以为数组对象，有点类似rules。当其为数组对象，说明里面必定存在更多的可选项，具体上npm搜索。

- externals的出现是为了加速webpack的打包，抽离部分代码不要令其打包进webpack里面去。 ex. CDN引入的资源

  > // main.js
  > externals: {
  >  // require('data') is external and available
  >  //  on the global var data
  >  'data': 'data'
  > }
  >
  > // index.html
  > let data = require('data');

  - 易错地方

```javascript
var devFlagPlugin = new webpack.DefinePlugin({
`__DEV__`: JSON.stringify(JSON.parse(process.env.DEBUG || 'false'))
});
这个在config文件里面声明，但是在main.js文件里面却可以取得到`__DEV__`的值，足以说明，webpack提供一个API，用于打包工具和main.js通信，不过变量DefinePlugin需要放在plugins数组里面不然获取不到值

# 考察点七
entry: {
   app: './main.js',
   vendor: ['jquery'],
 },
plugins: [
   new webpack.optimize.CommonsChunkPlugin({
     name: 'vendor',
     filename: 'vendor.js'
   })
 ]
//entry 新语法(对象),结合plugins里面的CommonsChunkPlugin

```



#### 封装一个npm包需要注意什么

1. 使用TS的话，需要注意babel配置
2. .gitignore、eslintrc.js配置、.editorconfig配置、jest.config.json配置、.yarnrc和.npmrc源配置，授权配置、License文件、Readme以及发布包的时候配置、提交代码规范的配置

