import { Duration } from "aws-cdk-lib";
import { Alarm, ComparisonOperator, Metric, TreatMissingData } from "aws-cdk-lib/aws-cloudwatch";
import { FilterPattern, MetricFilter } from "aws-cdk-lib/aws-logs";

export const createLambdaErrorAlarm = (stack: any, functionName: string, lambda: any) => {
  // Create metric filter for error logs
  const logGroup = lambda.logGroup;
  const errorMetricFilter = new MetricFilter(stack, `${functionName}ErrorLogFilter`, {
    logGroup,
    filterPattern: FilterPattern.anyTerm('error', 'Error', 'ERROR', 'exception', 'Exception', 'EXCEPTION', 'fail', 'Fail', 'FAIL'),
    metricNamespace: 'LambdaLogErrors',
    metricName: `${functionName}ErrorLogs`,
  });

  // Alarm for error logs
  new Alarm(stack, `${functionName}LogErrorAlarm`, {
    metric: errorMetricFilter.metric({
      period: Duration.minutes(1),
      statistic: 'Sum',
    }),
    threshold: 1,
    comparisonOperator: ComparisonOperator.GREATER_THAN_OR_EQUAL_TO_THRESHOLD,
    evaluationPeriods: 1,
    treatMissingData: TreatMissingData.NOT_BREACHING,
    alarmDescription: `Alert when ${functionName} logs contain error messages`,
  });

  // Alarm for Lambda execution errors
  new Alarm(stack, `${functionName}ErrorAlarm`, {
    metric: new Metric({
      namespace: 'AWS/Lambda',
      metricName: 'Errors',
      dimensionsMap: {
        FunctionName: lambda.functionName,
      },
      period: Duration.minutes(5),
      statistic: 'Sum',
    }),
    threshold: 1,
    comparisonOperator: ComparisonOperator.GREATER_THAN_OR_EQUAL_TO_THRESHOLD,
    evaluationPeriods: 1,
    treatMissingData: TreatMissingData.NOT_BREACHING,
    alarmDescription: `Alert when ${functionName} has errors`,
  });
};
