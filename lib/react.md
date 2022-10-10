## React大纲

- [基本使用语法](#基本使用语法)







#### 基本使用语法

```javascript
# 根组件渲染和普通组件渲染函数不一样
import ReactDOM from "react-dom/client";
import App from "./app"
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
	<App />
)

# 普通组件渲染
function originalComp () {
    return (
    	<div>
        // 这里编写你的代码
        <div/>
    )
}

# 需要传递props组件的话，需要继承React.Component,并且需要在render函数里面渲染
class OriginalComp extends React.Component {
    render () {
        return (
        	<div>
             // 这里编写你的代码
            <div/>
        )
    }
}
```

