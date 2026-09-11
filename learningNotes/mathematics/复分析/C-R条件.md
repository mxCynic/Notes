一个复变方程解析的充要条件是：
$$
\begin{align}
\frac{\partial u}{\partial x}&=\frac{\partial v}{\partial y} \\
\frac{\partial v}{\partial x}&=-\frac{\partial u}{\partial y}
\end{align}
$$
## 证明：
根据导数的定义：
$$ f(z+ \Delta z) - f(z) = \alpha \Delta z + o(|\Delta z|)
$$

其中：
$$\alpha = a + bi
$$
即：
$$
\begin{align}
f(z+ \Delta z) - f(z) &= \alpha \Delta z + o(|\Delta z|) \\
&=(a+bi) (\Delta x + \Delta y i)+ o(|\Delta z|) \\
&=(a \Delta x -b\Delta y) + (b\Delta x + a \Delta y)i + o(|\Delta z|)\\

\end{align}

$$
接下来，我们用$u$和$v$两个函数表示，也就是：
$$
\begin{align}
u(x+\Delta x, y+\Delta y) - u(x, y) &= a \Delta x -b\Delta y+ o(|\Delta z|) \\
v(x+\Delta x, y+\Delta y) - v(x, y) &= b \Delta x +a\Delta y+ o(|\Delta z|)
\end{align}

$$
观察上面这两个式子，我们可以和清楚的看到：
$$
\begin{align}
\frac{\partial u}{\partial x} = a, \frac{\partial v}{\partial y} = a \\
\frac{\partial u}{\partial y} = -b, \frac{\partial v}{\partial x} = b \\
\end{align}
$$
综上，我们有了C-R条件