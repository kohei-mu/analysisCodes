#original
x <- seq(0, 10 * pi, length=100)
sin_original <- sin(x)
plot(sin_original, type="l", ylim=c(-2, 3), main="sin original")

#fft original wave
c <- fft(sin_original)
c_fft <- abs(c/length(x))[2:length(c)]
plot(c_fft, type="l", main="original fft")

#composite target 1
x2 <- seq(0, 4 * pi, length=100)
sin2 <- sin(x2)
plot(sin2, type="l", ylim=c(-2, 3), main="composite wave 1")

#composite target 2
x3 <- seq(0, 14 * pi, length=100)
sin3 <- sin(x3)
plot(sin3, type="l", ylim=c(-2, 3), main="composite wave 2")

#wave composition
sin_composed <- sin_original + 0.3*sin2 + 0.3*sin3
plot(sin_composed, type="l", ylim=c(-2, 3), main="composed wave")

#fft composed wave 
c_composed <- fft(sin_composed)
c_composed_fft <- abs(c_composed/length(x))[2:length(c_composed)]
plot(c_composed_fft, type="l", main="composed wave fft")

