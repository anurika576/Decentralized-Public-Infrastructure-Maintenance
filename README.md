# Decentralized Public Infrastructure Maintenance

## Overview

This project implements a blockchain-based solution for transparent and efficient management of public infrastructure maintenance. By decentralizing the maintenance process, the system creates accountability, improves coordination between stakeholders, and ensures proper allocation of resources for public infrastructure upkeep.

## Key Components

### Asset Registration Contract
- Records essential details of public infrastructure assets
- Maintains comprehensive history of each asset's lifecycle
- Stores specifications, installation dates, expected lifespan
- Links assets to geographical locations and responsible jurisdictions

### Inspection Scheduling Contract
- Manages regular condition assessments of infrastructure assets
- Automates scheduling based on asset type, age, and criticality
- Generates inspection tasks with clear requirements
- Tracks inspection history and compliance

### Maintenance Request Contract
- Tracks identified repair needs from inspections or public reports
- Prioritizes issues based on urgency, safety impact, and resource availability
- Maintains transparent status updates on pending maintenance
- Facilitates funding allocation for approved maintenance tasks

### Contractor Verification Contract
- Validates qualified service providers for maintenance work
- Maintains contractor credentials, certifications, and specializations
- Implements reputation system based on work quality and reliability
- Ensures only approved contractors can bid on and perform maintenance tasks

### Work Verification Contract
- Records completed maintenance activities with immutable proof
- Validates work against original maintenance requests
- Stores before/after documentation and quality assessments
- Triggers payment release upon successful verification

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/decentralized-infrastructure-maintenance.git

# Navigate to project directory
cd decentralized-infrastructure-maintenance

# Install dependencies
npm install

# Compile smart contracts
truffle compile

# Deploy to test network
truffle migrate --network testnet
```

## Configuration

1. Create a `.env` file with your configuration parameters:
   ```
   BLOCKCHAIN_ENDPOINT=<blockchain_network_url>
   ADMIN_WALLET_PRIVATE_KEY=<admin_private_key>
   IPFS_GATEWAY=<ipfs_gateway_address>
   ```

2. Update `config.json` with your jurisdiction-specific parameters and compliance requirements.

## Usage

### Register Infrastructure Asset
```javascript
const assetContract = await AssetRegistration.deployed();
await assetContract.registerAsset(
  "Bridge-42A", 
  "Highway Bridge",
  "Steel and concrete, 120m span", 
  "41.8781,-87.6298", // coordinates
  "2015-03-15", // installation date
  "50", // expected lifespan in years
  "city_dept_hash", // responsible department identifier
  {from: authorizedAccount}
);
```

### Schedule Inspection
```javascript
const inspectionContract = await InspectionScheduling.deployed();
await inspectionContract.scheduleInspection(
  "Bridge-42A",
  "Structural Integrity Assessment",
  "2023-05-15", // scheduled date
  "Engineering Firm A", // assigned inspector
  {from: departmentAccount}
);
```

### Submit Maintenance Request
```javascript
const maintenanceContract = await MaintenanceRequest.deployed();
await maintenanceContract.createRequest(
  "Bridge-42A",
  "Repair crack in support beam",
  "High", // priority
  "Support beam Alpha-3 shows 5cm crack requiring immediate attention",
  "inspection_report_hash",
  "photo_evidence_hash",
  estimatedCost,
  {from: inspectorAccount}
);
```

### Verify Contractor
```javascript
const contractorContract = await ContractorVerification.deployed();
await contractorContract.registerContractor(
  "Infrastructure Repairs Inc.",
  "contractor_credentials_hash",
  ["Bridge Repair", "Concrete Work", "Structural Engineering"],
  "insurance_documentation_hash",
  {from: adminAccount}
);
```

### Verify Completed Work
```javascript
const workContract = await WorkVerification.deployed();
await workContract.verifyCompletion(
  "MTN-2023-0042", // maintenance request ID
  "work_documentation_hash",
  "after_repair_photos_hash",
  "quality_assessment_hash",
  {from: inspectorAccount}
);
```

## Governance

The system implements a multi-stakeholder governance model:
- Municipal authorities can register assets and approve maintenance budgets
- Certified inspectors can submit maintenance requests
- Citizens can report issues and view maintenance status
- Contractors can bid on approved maintenance tasks
- Independent verifiers confirm work completion

## Security Features

- Multi-signature requirements for budget approvals
- Role-based access control for different stakeholder actions
- Tamper-proof historical records of all infrastructure activities
- Transparent audit trails for public accountability
- Encrypted storage of sensitive infrastructure information

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-functionality`)
3. Commit your changes (`git commit -m 'Add new functionality'`)
4. Push to the branch (`git push origin feature/new-functionality`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository or contact the project team at support@decentralized-infrastructure.org
