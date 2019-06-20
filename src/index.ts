import { spawn } from "child_process";
import { config } from "dotenv";
import * as path from "path";

const main = async () => {
  const targetEnv = path.join(process.env.PWD as string, ".env");

  config({ path: targetEnv });

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

  const options: string[] = [];

  for (const co of dockerComposes) {
    options.push("-f");
    options.push(co);
  }

  options.push(...argvTopass);

  const childProcess = spawn("docker-compose", options, {
    stdio: "inherit",
    env: {
      ...process.env
    }
  });

  childProcess.on("exit", code => {
    process.exit(code === null ? 0 : code);
  });
};

main();
