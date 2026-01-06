import { Request, Response, Router } from "express";
import { validateBulkUpdateRequest } from "../validators/bulkUpdate.validator";
import { bulkUpdateService } from "../services/bulkUpdate.service";

export function registerBulkUpdateRoute(router: Router, context: any) {
  router.post('/:collection', async (req: Request, res: Response) => {
    try {
      const accountability = (req as any).accountability;
      const collection = req.params.collection;

      if (!collection || typeof collection !== 'string') {
        return res.status(400).json({
          success: false,
          message: 'Collection parameter is required in URL path'
        });
      }

      const payload = validateBulkUpdateRequest(req.body);
      const result = await bulkUpdateService(collection, payload, accountability, context);

      return res.json(result);
    } catch (error: any) {
      return res.status(error.status || 500).json({
        success: false,
        message: error.message
      });
    }
  });
}

