#original
x <- seq(0, 10 * pi, length=100)
sin_original <- sin(x)
plot(sin_original, type="l", main="sin original")

#fft original wave
c <- fft(sin_original)
c_len <- round(length(c)/2)
c_fft <- Mod(c)[1:c_len] 
plot(c_fft, type="l", main="original FFT")


a <- c_fft/2
b <- c_fft/2
j <- 1
for(i in seq(length(b), 1, by=-1)){
  a <- append(a, b[i])
  j <- j + 1
}

plot(c_fft, type="l", main="original FFT")

c_inverse <- fft(c_fft, inverse = TRUE) / length(c_fft)
plot(2:length(c), append(c_inverse,c_inverse[2:length(c_inverse)]), type="l", main="inversed_fft")

# add random sin
sin_tmp <- sin_original
for (freq in seq(0, c_len, by=1)){
  x <- seq(0, freq * pi, length=100)
  sin_add <- sin(x)
  sin_tmp <-sin_tmp + runif(1) * sin_add
}
plot(sin_tmp, type="l", main="composite wave with random sin")
c_random <- fft(sin_tmp)
c_random_fft <- Mod(c_random)[1:c_len]
plot(c_random_fft, type="l", main="composed wave FFT with random sin")

#composite target 1
x2 <- seq(0, 4 * pi, length=100)
sin2 <- sin(x2)
plot(sin2, type="l", ylim=c(-2, 3), main="composite wave 1")

#composite target 2
x3 <- seq(0, 14 * pi, length=100)
sin3 <- sin(x3)
plot(sin3, type="l", ylim=c(-2, 3), main="composite wave 2")

#wave composition
sin_composed <- sin_tmp + 0.3*sin2 + 0.3*sin3
plot(sin_composed, type="l", main="composed wave with specific freq")

#fft composed wave 
c_composed <- fft(sin_composed)
c_composed_fft <- Mod(c_composed)[1:c_len]
plot(c_composed_fft, type="l", main="composed wave FFT with specific freq")

