Challenge Name: AWS Resilient E-commerce Platform
Background: The exponential growth of online shopping necessitates robust and scalable e-commerce platforms. An increase in traffic during peak shopping periods like Black Friday or Cyber Monday requires the e-commerce platform to be highly resilient and responsive.
Challenge Objective: Build a highly scalable, resilient, and cost-effective e-commerce platform on AWS that can handle varying loads, survive component failures without user-visible errors, and maintain data consistency.
Requirements:
Cloud Formation and Infrastructure as Code (IaC): Use AWS CloudFormation to define and provision the entire infrastructure needed for the e-commerce platform. The architecture must be declared through IaC practices for versioning and reusability.
Microservices Architecture: Design the application using a microservices architecture, allowing the independent scaling and deployment of individual service components.
Load Balancing and Auto-scaling:
Implement Elastic Load Balancing (ELB) to distribute incoming application traffic across multiple targets.
Configure Auto Scaling to automatically adjust the number of EC2 instances in response to the application's workload.
Database and Caching:
Utilize Amazon RDS for relational databases with read replicas to handle peak read loads.
Implement Amazon DynamoDB for NoSQL requirements to manage cart and session data.
Implement caching using Amazon ElastiCache to reduce the load on databases during high traffic.
Message Queuing and Streaming:
Use Amazon SQS for decoupling application components.
Utilize Amazon Kinesis for real-time data streaming and processing for activities like clickstream analysis.
Storage and CDN:
Use Amazon S3 for storing static content and product media.
Integrate Amazon CloudFront as a CDN to deliver content globally with low latency.
Security and Compliance:
Implement AWS Identity and Access Management (IAM) to manage access.
Apply AWS WAF on ELB and CloudFront to safeguard against web exploits.
Ensure that the application complies with relevant standards and regulations such as GDPR and PCI DSS.
Monitoring, Logging, and Alerts:
Utilize AWS CloudWatch for monitoring the health and performance metrics of AWS resources.
Use AWS CloudTrail to monitor and log account activity.
Set up alerts to notify administrators of any critical issues or irregular patterns.
Disaster Recovery and Data Backup:
Establish a multi-AZ deployment to ensure high availability.
Implement replication across different geographical regions to protect against region-level failures.
Create a backup strategy using Amazon S3 lifecycle policies and Amazon Glacier for long-term data archiving.
Cost Optimization:
Perform cost-benefit analysis for the use of various services.
Use AWS Trusted Advisor for recommendations on how to save costs.
Implement AWS Budgets to track and manage costs.
Deliverables:
A written architecture design document.
AWS CloudFormation template files.
A cost analysis report.
Instructions for scaling, backup, and disaster recovery

**Resolved**

1. Infastructure Design
![Infastructure Design](/Infastructure-Design.png)
