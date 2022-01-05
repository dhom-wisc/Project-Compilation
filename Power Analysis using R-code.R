#F1:
p_control <- 0.20
p_treat <- 0.21
power.prop.test(n=NULL, p1 = p_control, p2 = p_treat, sig.level = 0.05, power = 0.80, alternative = "one.sided", strict= FALSE)
n <- round(20151,0)
N <- round(n*2,0)

p_control <- 0.20
control_rates <- rep(p_control,n)
p_treat <- (p_control + rnorm(n=1, mean=0, sd= 0.01))
rm(list = ls())
n <- round(20151,0)
control_rates <- rep(p_control, n)
ate_sims_f <- c()
pval_sims_f <- c()
treatment_rates <- c()
true_means <- c()
for (i in 1:4999){
  p_control <- 0.20
  tempcontrol <- runif(n)
  success_control <- as.integer(tempcontrol<p_control)
  
  p_treat <- (p_control + rnorm(n=1, mean=0, sd= 0.01))
  treatment_rates <- c(treatment_rates, p_treat)
  temptreat <- runif(n)
  success_treat <- as.integer(temptreat<p_treat)
  
  results_t <- t.test(success_treat, success_control, alternative = "greater")
  
  pval_sims_f <- c(pval_sims_f, results_t$p.value)
  ate_sims_f <- c(ate_sims_f, mean(success_treat)- mean(success_control))
}
true_means[ate_sims_f > 0 & pval_sims_f < 0.05] <- treatment_rates[ate_sims_f>0 & pval_sims_f < 0.05]
true_means
true_means[ate_sims_f < 0 | pval_sims_f > 0.05] <- control_rates[ate_sims_f<0 | pval_sims_f > 0.05]
true_means
mean(true_means,na.rm = TRUE)
hist(true_means, col = "forest green", main = "Histogram of True Success Rates", xlab = "Rates")
#-----------------------------------------------------------------------------------------------------------------------------------------
#F2:
rm(list = ls())
p_control <- 0.20
p_treat <- 0.21
power.prop.test(n=NULL, p1 = p_control, p2 = p_treat, sig.level = 0.50, power = 0.95, alternative = "one.sided", strict = FALSE)
n <- round(8817,0)
control_rates_f2 <- c()
ate_sims_f2 <- c()
pval_sims_f2 <- c()
treatment_rates_f2 <- c()
true_means_f2 <- c()

for (i in 1:4999){
  p_control <- 0.20
  tempcontrol <- runif(n)
  success_control <- as.integer(tempcontrol < p_control)
  
  p_treat <- (p_control + rnorm(n=1, mean = 0, sd = 0.01))
  treatment_rates_f2 <- c(treatment_rates_f2, p_treat)
  temptreat <- runif(n)
  success_treat <- as.integer(temptreat < p_treat)
  
  results_t <- t.test(success_treat, success_control, alternative = "greater")
  
  pval_sims_f2 <- c(pval_sims_f2, results_t$p.value)
  ate_sims_f2 <- c(ate_sims_f2, mean(success_treat) - mean(success_control))
}
true_means_f2 <- c()
true_means_f2[ate_sims_f2 > 0] <- treatment_rates_f2[ate_sims_f2 > 0]
true_means_f2[ate_sims_f2 < 0] <- control_rates_f2[ate_sims_f2 < 0]
true_means_f2
mean(true_means_f2,na.rm = TRUE)
hist(true_means_f2, col = 'blue', main = "Histogram of 'Go for It' True Success Rates", xlab = "Rates")

