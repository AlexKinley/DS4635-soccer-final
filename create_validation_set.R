matches <- read.csv("train.csv")
match_res <- read.csv("train_target_and_scores.csv")

nrow(matches)
nrow(match_res)

split <- sample(c(rep(0, 0.85*nrow(matches)), rep(1, 0.15*nrow(matches))))

matches_train <- matches[split==0,]
match_res_train <- match_res[split==0,]
nrow(matches_train)
nrow(match_res_train)
matches_test <- matches[split==1,]
match_res_test <- match_res[split==1,]
nrow(matches_test)
nrow(match_res_test)

write.csv(matches_train, "matches_train.csv")
write.csv(match_res_train, "match_res_train.csv")

write.csv(matches_test, "matches_test.csv")
write.csv(match_res_test, "match_res_test.csv")
                
              