import { Router } from "express";
import { registerBulkUpdateRoute } from "./routes/bulk-update.route";

export default (router: Router, context: any) => {
  registerBulkUpdateRoute(router, context);
};
