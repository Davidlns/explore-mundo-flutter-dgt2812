from pathlib import Path

from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import cm
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer


ROOT = Path(__file__).resolve().parent
SOURCE = ROOT / "documentacao_projeto.md"
TARGET = ROOT / "documentacao_projeto.pdf"


def build_story():
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        "DocTitle",
        parent=styles["Title"],
        fontName="Helvetica-Bold",
        fontSize=18,
        leading=24,
        spaceAfter=12,
    )
    heading_style = ParagraphStyle(
        "DocHeading",
        parent=styles["Heading2"],
        fontName="Helvetica-Bold",
        fontSize=13,
        leading=18,
        spaceBefore=8,
        spaceAfter=6,
    )
    body_style = ParagraphStyle(
        "DocBody",
        parent=styles["BodyText"],
        fontName="Helvetica",
        fontSize=10.5,
        leading=15,
        spaceAfter=6,
    )

    story = []

    for raw_line in SOURCE.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line:
            story.append(Spacer(1, 0.2 * cm))
            continue

        escaped = (
            line.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        )

        if line.startswith("# "):
            story.append(Paragraph(escaped[2:], title_style))
            continue

        if line.startswith("## "):
            story.append(Paragraph(escaped[3:], heading_style))
            continue

        if line.startswith("- "):
            story.append(Paragraph(f"• {escaped[2:]}", body_style))
            continue

        story.append(Paragraph(escaped, body_style))

    return story


def main():
    doc = SimpleDocTemplate(
        str(TARGET),
        pagesize=A4,
        rightMargin=2 * cm,
        leftMargin=2 * cm,
        topMargin=2 * cm,
        bottomMargin=2 * cm,
        title="Documentacao do Projeto",
    )
    doc.build(build_story())


if __name__ == "__main__":
    main()
