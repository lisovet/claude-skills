#!/usr/bin/env python3
"""Generate images using Google's Gemini (Nano Banana) image generation API."""

import argparse
import base64
import mimetypes
import os
import sys
from pathlib import Path

try:
    from google import genai
    from google.genai import types
except ImportError:
    print("Error: google-genai package not installed. Run: pip install google-genai", file=sys.stderr)
    sys.exit(1)


def _load_image_part(image_path: str) -> types.Part:
    """Load an image file and return a Gemini Part with inline data."""
    path = Path(image_path)
    if not path.exists():
        print(f"Error: Reference image not found: {image_path}", file=sys.stderr)
        sys.exit(1)
    mime_type = mimetypes.guess_type(str(path))[0] or "image/png"
    image_bytes = path.read_bytes()
    return types.Part.from_bytes(data=image_bytes, mime_type=mime_type)


def generate_image(
    prompt: str,
    output_path: str = "output.png",
    model: str = "gemini-2.5-flash-image",
    aspect_ratio: str | None = None,
    reference_images: list[str] | None = None,
) -> str:
    """Generate an image from a text prompt using the Gemini API.

    Args:
        prompt: Text description of the image to generate.
        output_path: Where to save the generated image.
        model: Gemini model ID.
        aspect_ratio: Optional aspect ratio (e.g., "4:5", "1:1", "9:16").
        reference_images: Optional list of file paths to reference images.
            These are sent alongside the prompt so the model can match
            product appearance, colors, and branding.
    """
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY environment variable not set.", file=sys.stderr)
        print("Get a key at https://aistudio.google.com/apikey", file=sys.stderr)
        sys.exit(1)

    client = genai.Client(api_key=api_key)

    config = types.GenerateContentConfig(
        response_modalities=["image", "text"],
    )

    # Build contents: reference images first, then the text prompt
    if reference_images:
        parts = []
        for img_path in reference_images:
            parts.append(_load_image_part(img_path))
        parts.append(types.Part.from_text(text=prompt))
        contents = [types.Content(parts=parts)]
    else:
        contents = prompt

    response = client.models.generate_content(
        model=model,
        contents=contents,
        config=config,
    )

    # Extract the image from the response
    output = Path(output_path)
    for part in response.candidates[0].content.parts:
        if part.inline_data is not None:
            image_data = part.inline_data.data
            # Ensure parent directory exists
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_bytes(image_data)
            print(f"Image saved to: {output.resolve()}")
            return str(output.resolve())
        elif part.text is not None:
            print(f"Model note: {part.text}", file=sys.stderr)

    print("Error: No image was generated. The model may have refused the prompt.", file=sys.stderr)
    sys.exit(1)


def main():
    parser = argparse.ArgumentParser(description="Generate images with Nano Banana (Gemini)")
    parser.add_argument("--prompt", "-p", required=True, help="The image generation prompt")
    parser.add_argument("--output", "-o", default="output.png", help="Output file path (default: output.png)")
    parser.add_argument(
        "--model", "-m",
        default="gemini-2.5-flash-image",
        help="Gemini model to use (default: gemini-2.5-flash-image)",
    )
    parser.add_argument("--aspect-ratio", "-a", help="Aspect ratio (e.g., 16:9, 9:16, 1:1)")
    parser.add_argument(
        "--ref", "-r",
        action="append",
        dest="reference_images",
        help="Path to a reference image (can be repeated up to 14 times)",
    )
    args = parser.parse_args()

    generate_image(
        prompt=args.prompt,
        output_path=args.output,
        model=args.model,
        aspect_ratio=args.aspect_ratio,
        reference_images=args.reference_images,
    )


if __name__ == "__main__":
    main()
