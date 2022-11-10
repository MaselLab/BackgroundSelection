install.packages("ggplot2")
library("ggplot2")
library('egg')


NeoverNdata <- data.frame(N = c(4000, 5000, 6000, 7500, 8000, 9000, 10000, 15000, 20000, 30000), Ne = c(4812, 5753, 6539, 7613, 8066, 8542, 9236, 13740, 17958, 26865))

fwdpyNeoverNdata <- data.frame(N = c(4000, 5000, 6000, 7000, 8000, 9000, 4000, 5000, 6000, 9000, 4000, 5000, 6000, 7000), Ne = c(934, 1009, 1152, 1386, 1559, 1694, 1792, 1783, 2221, 2950, 2360, 2108, 3079, 3100), Ud = c(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 0.02, 0.02, 0.02, 0.02, 0.0002, 0.0002, 0.0002, 0.0002))

UvsNefwdydata <- data.frame(U = c(0.02, 0.05, 0.1, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.75, 1, 1.25, 1.5, 2.0, 4.0), NeoverN = c(0.9536, 0.9196, 0.9662, 0.9202, 0.9394, 0.9036, 0.9044, 0.8698, 0.8674, 0.8782, 0.8416, 0.833, 0.811, 0.7764, 0.7376, 0.6006))

noblocksUvsNedata <- data.frame(U = c(0.001, 0.0025, 0.005, 0.0075, 0.01, 0.02, 0.025, 0.05, 0.075, 0.09, 0.1, 0.125, 0.2, 0.25, 0.5, 0.75, 1.0, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.959, 0.9476, 0.9484, 1.0242, 0.966, 0.946, 0.9554, 0.9328, 0.9386, 0.9454, 0.9036, 0.9384, 0.9176, 0.9232, 0.865, 0.8396, 0.8442, 0.7334, 0.6218, 0.512, 0.4474))

#01 after sd means sd = -0.01, using only digits after decimal point.
NeoverNbyUsd01data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.9452, 0.9486, 0.9452, 0.9446, 0.9704, 0.9256, 0.9228, 0.8954, 0.9090, 0.8590, 0.8200, 0.8288, 0.8200, 0.7776, 0.6582, 0.5650, 0.4754), s = c(0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01))
NeoverNbyUsd02data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.9412, 0.957, 0.9814, 0.9436, 0.923, 0.9608, 0.9454, 0.8864, 0.8768, 0.8546, 0.817, 0.7922, 0.7608, 0.7066, 0.5666, 0.4412, 0.3478))
NeoverNbyUsd005data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.9488, 0.9668, 0.9896, 0.9538, 0.9644, 0.928, 0.9424, 0.8868, 0.8672, 0.8564, 0.8532, 0.857, 0.8282, 0.797, 0.672, 0.608, 0.507))
NeoverNbyUsd0025data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.931, 0.9268, 1.0334, 0.9414, 0.9336, 0.932, 0.8874, 0.896, 0.8892, 0.855, 0.8424, 0.8242, 0.7922, 0.7748, 0.624, 0.5114, 0.4218), s = c(0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025, 0.0025))
NeoverNbyUsd04data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.982, 1.0044, 0.943, 0.9506, 0.9536, 0.971, 0.9014, 0.8858, 0.8604, 0.816, 0.7548, 0.732, 0.682, 0.6194, 0.393, 0.2712, 0.1826), s = c(0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04, 0.04))

NeoverNbyUgenessd0025N2000data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.95925, 0.9822, 0.9796, 0.9464, 0.948, 0.9424, 1.045, 0.9788, 1.049, 1.034, 0.9788, 1.002, 0.95075, 1.0116, 0.7796, 0.8396, 0.8019))
NeoverNbyUgenessd01N5000data <- data.frame(U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), NeoverN = c(0.9491, 0.9712, 0.947, 0.94125, 0.97345, 0.93385, 0.94185, 0.904, 0.9122, 0.9406, 0.90905, 0.82755, 0.8226, 0.6526, 0.5733, 0.4459, 0.32675))

NeoverNbyUfullDFEvsnoDFEdata <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.025, 0.05, 0.075, 0.09, 0.1, 0.125, 0.2, 0.25, 0.5, 0.75, 1.0, 2.0, 4.0, 6.0, 8.0),
  NeoverN = c(0.9452, 0.9486, 0.9452, 0.9446, 0.9704, 0.9256, 0.9228, 0.8954, 0.9090, 0.8590, 0.8200, 0.8288, 0.8200, 0.7776, 0.6582, 0.5650, 0.4754, 0.966, 0.946, 0.9554, 0.9328, 0.9386, 0.9454, 0.9036, 0.9384, 0.9176, 0.9232, 0.865, 0.8396, 0.8442, 0.7334, 0.6218, 0.512, 0.4474),
  DFE = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUthreeNdata <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0), 
  NeoverN = c(0.9452, 0.9486, 0.9452, 0.9446, 0.9704, 0.9256, 0.9228, 0.8954, 0.9090, 0.8590, 0.8200, 0.8288, 0.8200, 0.7776, 0.6582, 0.5650, 0.4754, 0.9235, 0.9815, 0.9635, 0.9645, 0.981, 0.9565, 0.91, 0.9115, 0.8925, 0.866, 0.866, 0.825, 0.855, 0.7635, 0.6415, 0.5695, 0.4735, 0.9515, 0.9840, 0.9488, 0.9283, 0.9229, 0.9629, 0.9336, 0.8995, 0.8961, 0.8700, 0.8415, 0.8403, 0.7961, 0.7722, 0.6652, 0.5554, 0.4618), 
  N = c(5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000, 10000)
  )

NeoverNbyUgenesvsnogenesN2000sd0025data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0),
  NeoverN = c(0.931, 0.9268, 1.0334, 0.9414, 0.9336, 0.932, 0.8874, 0.896, 0.8892, 0.855, 0.8424, 0.8242, 0.7922, 0.7748, 0.624, 0.5114, 0.4218, 0.95925, 0.9822, 0.9796, 0.9464, 0.948, 0.9424, 1.045, 0.9788, 1.049, 1.034, 0.9788, 1.002, 0.95075, 1.0116, 0.7796, 0.8396, 0.8019),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUgenesvsnogenesN2000sd01data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0),
  NeoverN = c(0.931, 0.9268, 1.0334, 0.9414, 0.9336, 0.932, 0.8874, 0.896, 0.8892, 0.855, 0.8424, 0.8242, 0.7922, 0.7748, 0.624, 0.5114, 0.4218, 1.0346, 0.9393, 0.9411, 0.9483, 0.954, 0.9214, 0.917, 0.9174, 0.9041, 0.9705, 0.936, 0.8299, 0.8063, 0.8026, 0.5257, 0.467, 0.3405),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUgenesvsnogenesN5000sd01data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0),
  NeoverN = c(0.9452, 0.9486, 0.9452, 0.9446, 0.9704, 0.9256, 0.9228, 0.8954, 0.9090, 0.8590, 0.8200, 0.8288, 0.8200, 0.7776, 0.6582, 0.5650, 0.4754, 0.9491, 0.9712, 0.947, 0.94125, 0.97345, 0.93385, 0.94185, 0.904, 0.9122, 0.9406, 0.90905, 0.82755, 0.8226, 0.6526, 0.5733, 0.4459, 0.32675),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUgenesvsnogenesN10000sd01data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0),
  NeoverN = c(0.9515, 0.9840, 0.9488, 0.9283, 0.9229, 0.9629, 0.9336, 0.8995, 0.8961, 0.8700, 0.8415, 0.8403, 0.7961, 0.7722, 0.6652, 0.5554, 0.4618, 0.939, 0.9566, 0.9628, 0.9586, 0.93945, 0.9366, 0.9270, 0.9210, 0.9043, 0.88535, 0.8259, 0.6602, 0.4505, 0.5268, 0.3969, 0.3463, 0.3216),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUgenesvsnogenesN10000sd0025data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0),
  NeoverN = c(0.9532, 0.9561, 0.9510, 0.9611, 0.9550, 0.9353, 0.9309, 0.9076, 0.9029, 0.8969, 0.8899, 0.8830, 0.8705, 0.8474, 0.8109, 0.7511, 0.6981, 0.9883, 0.9335, 0.9573, 0.9352, 0.9262, 0.9358, 0.9282, 1.0194, 1.0075, 0.9797, 0.9213, 0.8621, 0.8489, 0.7947, 0.7974, 0.5240),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUgenesvsnogenesN10000sd04data <- data.frame(
  U = c(0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0, 8.0, 0.01, 0.02, 0.03, 0.05, 0.075, 0.1, 0.2, 0.35, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0, 4.0, 6.0),
  NeoverN = c(0.9578, 0.9935, 0.9560, 0.9478, 0.9614, 0.9304, 0.9338, 0.8809, 0.8411, 0.8068, 0.7733, 0.7203, 0.6954, 0.6162, 0.4007, 0.2703, 0.1803, 0.9776, 0.9358, 0.9591, 0.9377, 0.9422, 0.9715, 0.9175, 0.9093, 0.8895, 0.8436, 0.8175, 0.7920, 0.7703, 0.7135, 0.3963, 0.3379),
  genes = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
)

NeoverNbyUtwodsdata <- merge(NeoverNbyUsd0025data, NeoverNbyUsd01data, by = c('U', 'NeoverN', 's'), all = TRUE)
NeoverNbyUthreesdata <- merge(NeoverNbyUtwodsdata, NeoverNbyUsd04data, by = c('U', 'NeoverN', 's'), all = TRUE)
NeoverNbyUwithoutsd01data <- merge(NeoverNbyUsd0025data, NeoverNbyUsd04data, by = c('U', 'NeoverN', 's'), all = TRUE)

#Following code performs least-square analysis to fit the relationship between Ne/N and U
#Lines with 'noC' fit directly to a function of the form e^-kU
#Lines with 'plusC' fit to a function of the form C + e^-kU
UefitfornoblockswithDFEnoC <- nls(NeoverN ~ exp(-k*U), data = noblocksUvsNedata, start = list(k = 40))
UefitfornoblockswithDFEplusC <- nls(NeoverN ~ C + exp(-k*U), data = noblocksUvsNedata, start = list(C = -0.04, k = 0.2))
coef(UefitfornoblockswithDFEplusC)
coef(UefitfornoblockswithDFE)

UefitfornoblocksnoDFEplusC <- nls(NeoverN ~ C + exp(-k*U), data = NeoverNbyUsd01data, start = list(C = -0.04, k = 0.2))
coef(UefitfornoblocksnoDFEplusC)
UefitfornoblocksnoDFEplusC <- nls(NeoverN ~ C + exp(-k*U), data = NeoverNbyUsd02data, start = list(C = -0.04, k = 0.2))
coef(UefitfornoblocksnoDFEplusC)
UefitfornoblocksnoDFEplusC <- nls(NeoverN ~ C + exp(-k*U), data = NeoverNbyUsd005data, start = list(C = -0.04, k = 0.2))
coef(UefitfornoblocksnoDFEplusC)
UefitfornoblocksnoDFEplusC <- nls(NeoverN ~ C + exp(-k*U), data = NeoverNbyUsd04data, start = list(C = -0.04, k = 0.2))
coef(UefitfornoblocksnoDFEplusC)

NeoverNgraph <- ggplot(data = NeoverNdata, mapping = aes(y = (Ne/N), x = N)) +
  geom_point() +
  stat_function(fun = function (x) (0.957)) +
  theme_classic(base_size = 15)

fwdpyNeoverNgraph <- ggplot(data = fwdpyNeoverNdata, mapping = aes(y = (Ne/N), x = N, color = as.factor(Ud))) +
  geom_point() +
  scale_y_continuous(limits = c(0.0, 1.0)) +
  stat_function(fun = function (x) (2196.2/5000)) +
  theme_classic(base_size = 15)

NeversusNgraph <- ggplot(data = NeoverNdata, mapping = aes(y = (Ne), x = N)) +
  geom_point() +
  stat_function(fun = function (x) (0.957*x)) +
  theme_classic(base_size = 15)

NeoverNbyUgraph <- ggplot(data = UvsNefwdydata, mapping = aes(y = NeoverN, x = U)) +
  geom_point() +
  scale_x_log10() +
  stat_function(fun = function (x) (0.957)) +
  theme_classic(base_size = 15)

NeoverNbyUgenesvsnogenesN2000sd0025graph <- ggplot(data = NeoverNbyUgenesvsnogenesN2000sd0025data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.001, 0.01, 0.1, 1.0, 10.0)) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme_classic()

NeoverNbyUgenesvsnogenesN2000sd01graph <- ggplot(data = NeoverNbyUgenesvsnogenesN2000sd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "light gray"),
        panel.border = element_rect(fill = NA), legend.position = c(0.81, 0.17), legend.text = element_text(size = 18), legend.title = element_blank(), legend.key.height = unit(0.6, 'cm'))

NeoverNbyUgenesvsnogenesN5000sd01graph <- ggplot(data = NeoverNbyUgenesvsnogenesN5000sd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "light gray"),
        panel.border = element_rect(fill = NA), legend.position = "none")

NeoverNbyUgenesvsnogenesN10000sd01graphforstackedplot <- ggplot(data = NeoverNbyUgenesvsnogenesN10000sd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), legend.position = "none")

NeoverNbyUgenesvsnogenesN10000sd01graph <- ggplot(data = NeoverNbyUgenesvsnogenesN10000sd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "light gray"),
        panel.border = element_rect(fill = NA), legend.position = "none")

NeoverNbyUgenesvsnogenesN10000sd0025graph <- ggplot(data = NeoverNbyUgenesvsnogenesN10000sd0025data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.00125*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "light gray"),
        panel.border = element_rect(fill = NA), legend.position = "none")

NeoverNbyUgenesvsnogenesN10000sd04graph <- ggplot(data = NeoverNbyUgenesvsnogenesN10000sd04data, mapping = aes(y = NeoverN, x = U, color = as.factor(genes))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.02*x*(91/92))), aes(color = 'black')) +
  scale_color_manual(name = "", labels = c("no genes", "genes", "equation"), values = c('blue', 'red', 'black')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=17), axis.text = element_text(size = 13.5), panel.background = element_rect(fill = "white"), panel.grid.major = element_line(colour = "light gray"), panel.border = element_rect(fill = NA), legend.position = "none")

noblockswithDFENeoverNbyUgraph <- ggplot(data = noblocksUvsNedata, mapping = aes(y = NeoverN, x = U)) +
  geom_point() +
  scale_x_log10(breaks = c(0.001, 0.01, 0.1, 1.0, 10.0)) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(color = "black")) +
  stat_function(fun = function (x) (exp(-x/10.4726122) - 0.05385236), aes(color = "green")) +
  stat_function(fun = function (x) (exp(-x/12.3590863323) - 0.06167355), aes(color = "brown")) +
  scale_color_identity(name = "", labels = c("Theoretical expectation (Hudson and Kaplan 1995)", "Single sd value of -0.01", "Full DFE"), guide = "legend") +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(panel.background = element_rect(fill = "white", colour = "grey50"), legend.position = c(0.5, 0.2))

noblocksnoDFENeoverNbyUgraph <- ggplot(data = NeoverNbyUwithoutsd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(s))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(color = 'black')) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*x*0.02*(91/92))), aes(color = 'orange')) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*x*0.00125*(91/92))), aes(color = 'yellow')) +
  scale_color_manual(name = "", labels = c("s = -0.0025", "s = -0.04", "linked only", "joint model, s = -0.04", "joint model, s = -0.0025"), values = c('green', 'blue', 'black', 'blue', 'green')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=20), axis.text = element_text(size = 18), panel.background = element_rect(fill = "white", colour = "grey50"), legend.text = element_text(size = 17))

NeoverNbyUpanelBtwosdgraph <- ggplot(data = NeoverNbyUwithoutsd01data, mapping = aes(y = NeoverN, x = U, color = as.factor(s))) +
  geom_point(show.legend = FALSE) +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(color = 'black'), size = 0.8, show.legend = FALSE) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*x*0.02*(91/92))), aes(color = 'orange'), size = 0.8, show.legend = FALSE) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*x*0.00125*(91/92))), aes(color = 'yellow'), size = 0.8, show.legend = FALSE) +
  scale_color_manual(name = "", labels = c("s = -0.0025", "s = -0.04", "linked only", "joint model, s = -0.04", "joint model, s = -0.0025"), values = c('green', 'blue', 'black', 'blue', 'green')) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  theme(text = element_text(size=16), axis.text = element_text(size = 18), panel.background = element_rect(fill = "white", colour = "grey50"), legend.text = element_text(size = 12))


a <- exp(-x/92)
b <- exp(-8*0.005*x)
c <- exp(-x/46)*exp(-8*0.005*x*(22/23))

NeoverNbyUthreeNsnoDFEnoblocksgraph <- ggplot(data = NeoverNbyUthreeNdata, mapping = aes(y = NeoverN, x = U, shape = as.factor(N))) +
  geom_point() +
  #geom_line(aes(y = exp(-U/92), linetype = "solid")) +
  #geom_line(aes(y = (exp(-8*0.005*U)), linetype = "dashed")) +
  #geom_line(aes(y = (exp(-U/46)*exp(-8*0.005*U*(22/23))), linetype = "dashdot")) +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(linetype = "linked only")) +
  stat_function(fun = function (x) (exp(-8*0.005*x)), aes(linetype = "unlinked only")) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(linetype = "both")) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  scale_shape_manual(name = "Population size", labels = c('2000', '5000', '10000'), values = c(0, 1, 2)) +
  scale_linetype_manual(name = "Theoretical expectation", values = c(4, 1, 2)) +
  theme(text = element_text(size=16), axis.text = element_text(size = 18), panel.background = element_rect(fill = "white", colour = "grey50"), legend.text = element_text(size = 12))

NeoverNbyUthreeNspanelAnolegendgraph <- ggplot(data = NeoverNbyUthreeNdata, mapping = aes(y = NeoverN, x = U, shape = as.factor(N))) +
  geom_point(show.legend = FALSE) +
  #geom_line(aes(y = exp(-U/92), linetype = "solid")) +
  #geom_line(aes(y = (exp(-8*0.005*U)), linetype = "dashed")) +
  #geom_line(aes(y = (exp(-U/46)*exp(-8*0.005*U*(22/23))), linetype = "dashdot")) +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/92)), aes(linetype = "linked only"), show.legend = FALSE, size = 0.8) +
  stat_function(fun = function (x) (exp(-8*0.005*x)), aes(linetype = "unlinked only"), show.legend = FALSE, size = 0.8) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(linetype = "both"), show.legend = FALSE, size = 0.8) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  scale_shape_manual(name = "Population size", labels = c('2000', '5000', '10000'), values = c(0, 1, 2)) +
  scale_linetype_manual(name = "Theoretical expectation", values = c(4, 1, 2)) +
  theme(text = element_text(size=16), axis.text = element_text(size = 18), panel.background = element_rect(fill = "white", colour = "grey50"), legend.text = element_text(size = 12))


NeoverNbyUfullDFEvsnoDFEgraph <- ggplot(data = NeoverNbyUfullDFEvsnoDFEdata, mapping = aes(y = NeoverN, x = U, color = as.factor(DFE))) +
  geom_point() +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = "black")) +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  scale_linetype_manual(labels = c('1', '2', '3')) +
  scale_color_manual(name = "", labels = c("Full DFE (Kim et al. 2017)", "Constant s = -0.01", "Linked + unlinked"), values = c('orange', 'purple', 'black')) +
  theme(text = element_text(size=20), axis.text = element_text(size = 18), 
        panel.background = element_rect(fill = "white", color = "grey50"),
        legend.text = element_text(size = 17), legend.key.height = unit(0.7, 'cm'))

NeoverNbyUpanelCDFEvsnoDFEgraph <- ggplot(data = NeoverNbyUfullDFEvsnoDFEdata, mapping = aes(y = NeoverN, x = U, color = as.factor(DFE))) +
  geom_point(show.legend = FALSE) +
  scale_x_log10(breaks = c(0.01, 0.1, 1.0, 10.0), labels = c("0.01", "0.1", "1", "10")) +
  scale_y_continuous(limits = c(0.0, 1.1)) +
  stat_function(fun = function (x) (exp(-x/46)*exp(-8*0.005*x*(91/92))), aes(color = "purple"), show.legend = FALSE, linetype = 4, size = 0.8, color = 'purple') +
  xlab("Genome-wide deleterious mutation rate") +
  ylab("Ne/N") +
  scale_linetype_manual(labels = c('1', '2', '3')) +
  scale_color_manual(name = "", labels = c("Full DFE (Kim et al. 2017)", "Constant s = -0.01", "Linked + unlinked"), values = c('orange', 'purple', 'black')) +
  theme(text = element_text(size=16), axis.text = element_text(size = 18), 
        panel.background = element_rect(fill = "white", color = "grey50"),
        legend.text = element_text(size = 12), legend.key.height = unit(0.7, 'cm'))


NeoverNgraph

NeversusNgraph

NeoverNbyUgraph

fwdpyNeoverNgraph

NeoverNbyUgenesvsnogenesN2000sd0025graph

NeoverNbyUgenesvsnogenesN2000sd01graph

NeoverNbyUgenesvsnogenesN5000sd01graph

NeoverNbyUgenesvsnogenesN10000sd01graphforstackedplot

NeoverNbyUgenesvsnogenesN10000sd01graph

NeoverNbyUgenesvsnogenesN10000sd0025graph

NeoverNbyUgenesvsnogenesN10000sd04graph

noblockswithDFENeoverNbyUgraph

noblocksnoDFENeoverNbyUgraph

NeoverNbyUfullDFEvsnoDFEgraph

NeoverNbyUthreeNsnoDFEnoblocksgraph

NeoverNbyUthreeNspanelAnolegendgraph

NeoverNbyUpanelBtwosdgraph

NeoverNbyUpanelCDFEvsnoDFEgraph

ggarrange(NeoverNbyUgenesvsnogenesN2000sd01graph +
            theme(axis.text.x = element_blank(), 
                  axis.ticks.x = element_blank(), 
                  axis.title.x = element_blank(), 
                  axis.title.y = element_text(size = 17),
                  axis.text.y = element_text(size = 13.5),
                  panel.background = element_rect(fill = "white"),
                  panel.grid.major = element_line(colour = "light gray"),
                  panel.border = element_rect(fill = NA),
                  legend.position = c(0.25, 0.45),
                  legend.background = element_blank()) +
            xlab("Genome-wide deleterious mutation rate") +
            ylab("Ne/N"), 
          NeoverNbyUgenesvsnogenesN5000sd01graph +
            theme(axis.text.x = element_blank(), 
                  axis.ticks.x = element_blank(), 
                  axis.title.x = element_blank(), 
                  axis.title.y = element_text(size = 17),
                  axis.text.y = element_text(size = 13.5),
                  panel.background = element_rect(fill = "white"),
                  panel.grid.major = element_line(colour = "light gray"),
                  panel.border = element_rect(fill = NA),
                  legend.position = "none",
                  legend.background = element_blank()) +
            xlab("Genome-wide deleterious mutation rate") +
            ylab("Ne/N"),
          NeoverNbyUgenesvsnogenesN10000sd01graph +
            theme_bw(base_size = 17) +
            theme(panel.grid.major = element_line(size = 0.5),
                  panel.grid.minor = element_blank(),
                  legend.position = "none",
                  legend.background = element_blank()) +
            xlab("Genome-wide deleterious mutation rate") +
            ylab("Ne/N"),
          nrow = 3)
  