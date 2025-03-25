import { defineFunction } from "@aws-amplify/backend";

export const requestRepeatWeekly = defineFunction({
  name: "request-repeat-weekly",
  schedule: "every 3h",
});
