import { spawn } from "child_process";
import { config } from "dotenv";
import * as path from "path";

const main = async () => {
  config({ path: path.join(process.cwd(), ".env") });

  const { DOCKER_COMPOSE_OVERRIDES } = process.env;

  if (
    typeof DOCKER_COMPOSE_OVERRIDES !== "string" ||
    !DOCKER_COMPOSE_OVERRIDES
  ) {
    console.error(`'DOCKER_COMPOSE_OVERRIDES' is required on env!`);
    return process.exit(1);
  }

  const dockerComposes = DOCKER_COMPOSE_OVERRIDES.split(",");

  const argvTopass = [...process.argv];
  argvTopass.shift();
  argvTopass.shift();

  const options = [...dockerComposes.map(file => `-f ${file}`), ...argvTopass];

  const childProcess = spawn("docker-compose", options, {
    stdio: [process.stdin, process.stdout, process.stderr]
  });
};

main();
